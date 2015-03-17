class User
  
  include QueryHelperModule

  attr_accessor :id, :fname, :lname
  
  def initialize(options={})
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end
  
  def self.find_by_name(fname, lname)
    results = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
    SELECT
      * 
    FROM
      users
    WHERE
      fname = ? AND lname = ?
    SQL
    results.map{ |result| User.new(result) }
  end
  
  def authored_questions
    Question.find_by_author_id(id)
  end
  
  def authored_replies
    Reply.find_by_author_id(id)
  end
  
  def followed_questions
    QuestionFollower.followed_questions_for_user_id(id)
  end
  
  def liked_questions
    QuestionLike.liked_questions_for_user_id(id)
  end
  
  def average_karma
    results = QuestionsDatabase.instance.execute(<<-SQL)
    SELECT
      CAST(COUNT(user_id) AS FLOAT) / COUNT(DISTINCT(questions.id)) 
    FROM
      questions LEFT OUTER JOIN question_likes ON (questions.id = question_id)
    WHERE
      questions.author_id = '#{ self.id }' 
    GROUP BY
      questions.id
    SQL
    results.first.values.first
  end
end
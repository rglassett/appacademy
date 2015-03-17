class QuestionFollower
  
  include QueryHelperModule
  
  attr_accessor :id, :user_id, :question_id
  
  def initialize(options={})
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end

  
  def self.followers_for_question_id(questionid)
    results = QuestionsDatabase.instance.execute(<<-SQL, questionid) 
    SELECT 
      users.*
    FROM question_followers JOIN users ON user_id = users.id
    WHERE 
      question_id = ?
    SQL
    results.map{ |result| User.new(result) }
  end
  
  def self.followed_questions_for_user_id(user_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, user_id) 
    SELECT
      questions.*
    FROM question_followers JOIN questions ON question_id = questions.id
    WHERE 
      user_id = ?
    SQL
    results.map{ |result| Question.new(result) }
  end
  
  def self.most_followed_questions(n)
    results = QuestionsDatabase.instance.execute(<<-SQL)
    SELECT
      questions.*, COUNT(user_id)
    FROM
      question_followers JOIN questions ON question_id = questions.id
    GROUP BY
      questions.id
    ORDER BY
      COUNT(user_id) DESC
    SQL
    results.take(n).map { |result| Question.new(result) }
  end
end
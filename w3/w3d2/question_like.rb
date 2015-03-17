class QuestionLike
  
  include QueryHelperModule
  
  attr_accessor :id, :user_id, :question_id
  
  def initialize(options={})
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end

  def self.likers_for_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        users.*
      FROM
        question_likes JOIN users ON (user_id = users.id)
      WHERE
        question_id = ?
    SQL
    results.map { |result| User.new(result) }
  end
  
  def self.num_likes_for_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        Count(users.id)
      FROM
        question_likes JOIN users ON (user_id = users.id)
      WHERE
        question_id = ?
    SQL
    results.first.values.first
  end
  
  def self.liked_questions_for_user_id(user_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        questions.*
      FROM
        question_likes JOIN questions ON (question_id = questions.id)
      WHERE
        user_id = ?
    SQL
    results.map { |result| Question.new(result) }
  end
  
  def self.most_liked_questions(n)
    results = QuestionsDatabase.instance.execute(<<-SQL)
    SELECT
      questions.*
    FROM
      question_likes JOIN questions ON question_id = questions.id
    GROUP BY
      questions.id
    ORDER BY
      COUNT(user_id) DESC
    SQL
    results.take(n).map { |result| Question.new(result) }
  end
  
end
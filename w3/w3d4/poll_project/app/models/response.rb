class Response < ActiveRecord::Base
  validates :respondent, :answer_choice, presence: true
  validate :respondent_is_not_poll_author, 
           :respondent_has_not_already_answered_question

  belongs_to(
    :respondent,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id
  )

  belongs_to(
    :answer_choice,
    class_name: 'AnswerChoice',
    foreign_key: :answer_choice_id,
    primary_key: :id
  )

  has_one(
    :question,
    through: :answer_choice,
    source: :question
  )

  def respondent_has_not_already_answered_question
    if sibling_responses.where('responses.user_id = ?', user_id).exists?
      errors[:user_id] << "can't respond to the same question multiple times"
    end
  end
  
  def respondent_is_not_poll_author
    poll_author_id = Poll.joins(questions: :answer_choices).
      where('answer_choices.id = ?', self.answer_choice_id).
      select('polls.author_id').first.author_id
      
    if poll_author_id == self.user_id
      errors[:author] << "can't respond to a poll you created"
    end
  end

  def sibling_responses
    if id.nil?
      sibling_responses_helper
    else
      sibling_responses_helper.where("responses.id != ?", id)
    end
  end
  
  private
  
  def sibling_responses_helper
    Response.joins("JOIN answer_choices AS b ON responses.answer_choice_id = b.id").
      joins("JOIN questions ON b.question_id = questions.id").
      joins("JOIN answer_choices AS a ON questions.id = a.question_id").
      where("a.id = ?", answer_choice_id)
  end
  
  # SQL query to get sibling responses
  # def shorter
  #   Response.find_by_sql([<<-SQL, answer_choice_id])
  #     SELECT DISTINCT
  #       responses.*
  #     FROM
  #       answer_choices a
  #     JOIN
  #       questions
  #     ON
  #       a.question_id = questions.id
  #     JOIN
  #       answer_choices b
  #     ON
  #       questions.id = b.question_id
  #     JOIN
  #       responses
  #     ON
  #       b.id = responses.answer_choice_id
  #     WHERE
  #       a.id = ? AND responses.id != ?
  #     SQL
  # end

  # Two query implementation
  # def sibling_responses
  #   if id.nil?
  #     self.question.responses
  #   else
  #     self.question.responses.where('responses.id != ?', id)
  #   end
  # end
end

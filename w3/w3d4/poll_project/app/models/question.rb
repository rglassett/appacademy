class Question < ActiveRecord::Base
  validates :text, :poll, presence: true
  before_destroy :destroy_answer_choices
  
  belongs_to(
    :poll,
    class_name: "Poll",
    foreign_key: :poll_id,
    primary_key: :id
  )
  
  has_many(
    :answer_choices,
    class_name: "AnswerChoice",
    foreign_key: :question_id,
    primary_key: :id
  )
  
  has_many(
    :responses,
    through: :answer_choices,
    source: :responses
  )
  
  def results
    results = {}

    arr = self.answer_choices.
      select("answer_choices.*, COUNT(responses.id) AS num_responses").
      joins("LEFT OUTER JOIN responses ON answer_choices.id = responses.answer_choice_id").
      group("answer_choices.id").to_a
    arr.each { |el| results[el.text] = el.num_responses }

    results
  end
  
  protected
  def destroy_answer_choices
    answer_choices.to_a.each { |answer_choice| answer_choice.destroy }
  end
end

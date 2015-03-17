class AnswerChoice < ActiveRecord::Base
  validates :text, :question, presence: true
  before_destroy :destroy_responses
  
  belongs_to(
    :question,
    class_name: "Question",
    foreign_key: :question_id,
    primary_key: :id
  )
  
  has_many(
    :responses,
    class_name: 'Response',
    foreign_key: :answer_choice_id,
    primary_key: :id
  )
  
  protected
  def destroy_responses
    responses.to_a.each { |response| response.destroy }
  end
end
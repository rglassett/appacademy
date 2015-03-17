class User < ActiveRecord::Base
  validates :user_name, presence: true, uniqueness: true
  
  has_many(
    :authored_polls,
    class_name: "Poll",
    foreign_key: :author_id,
    primary_key: :id
  )
  
  has_many(
    :responses,
    class_name: 'Response',
    foreign_key: :user_id,
    primary_key: :id
  )
  
  has_many(
    :received_responses,
    through: :authored_polls,
    source: :responses
  )
  
  def completed_polls
    poll_helper.
      having("COUNT(DISTINCT questions.id) = COUNT(DISTINCT responses.id)")
  end
  
  def uncompleted_polls
    poll_helper.
      having("COUNT(DISTINCT questions.id) > COUNT(DISTINCT responses.id)")
  end
  
  private
  
  def poll_helper
    Poll.joins(questions: :answer_choices).
      joins('LEFT OUTER JOIN responses ON responses.answer_choice_id =  answer_choices.id').
      where('responses.user_id = ? OR responses.user_id IS NULL', self.id).
      group('polls.id')
  end
  
 #  SQL query for completed_polls
 #  def completed_polls_sql
 #    Poll.find_by_sql([<<-SQL, id])
 #    SELECT
 #      polls.*
 #    FROM
 #      polls
 #    JOIN
 #      questions
 #    ON
 #      polls.id = questions.poll_id
 #    JOIN
 #      answer_choices
 #    ON
 #      questions.id = answer_choices.question_id
 #    LEFT OUTER JOIN (
 #      SELECT
 #        responses.*
 #      FROM
 #        responses
 #      WHERE
 #        responses.user_id = ?
 #    ) AS r
 #    ON
 #      answer_choices.id = r.answer_choice_id
 #    GROUP BY
 #      polls.id
 #    HAVING
 #     COUNT(DISTINCT questions.id) = COUNT(DISTINCT r.id)
 #    SQL
 #  end

  # SQL implementation without subquery
  # def completed_polls_no_subquery
  #   Poll.find_by_sql([<<-SQL, id])
  #     SELECT
  #       polls.*, COUNT(DISTINCT questions.id) q_count, COUNT(DISTINCT responses.id) r_count
  #     FROM
  #       polls
  #     JOIN
  #       questions
  #     ON
  #       polls.id = questions.poll_id
  #     JOIN
  #       answer_choices
  #     ON
  #       questions.id = answer_choices.question_id
  #     LEFT OUTER JOIN
  #       responses
  #     ON
  #       answer_choices.id = responses.answer_choice_id
  #     WHERE
  #       responses.user_id = ? OR responses.user_id IS NULL
  #     GROUP BY
  #       polls.id
  #     HAVING
  #       COUNT(DISTINCT questions.id) = COUNT(DISTINCT responses.id)
  #   SQL
  # end
end

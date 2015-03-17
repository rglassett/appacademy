class IndexResponses < ActiveRecord::Migration
  def change
    add_index(:responses, [:user_id, :answer_choice_id], unique: true)
  end
end

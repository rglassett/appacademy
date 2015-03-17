class ChangeComments < ActiveRecord::Migration
  def change
    remove_index :comments, [:commentable_id, :commentable_type]
    add_index :comments, [:commentable_id, :commentable_type]
  end
end

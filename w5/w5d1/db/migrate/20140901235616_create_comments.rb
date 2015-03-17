class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :commentable_type, null: false
      t.integer :commentable_id, null: false
      t.integer :author_id, null: false
      t.text :body, null: false

      t.timestamps
    end
    add_index :comments, :author_id
    add_index :comments, [:commentable_type, :commentable_id]
  end
end

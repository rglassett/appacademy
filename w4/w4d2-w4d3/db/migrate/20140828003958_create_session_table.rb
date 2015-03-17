class CreateSessionTable < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.integer :user_id, null: false
      t.string :token, null: false
      
      t.timestamps
    end
    
    remove_column :users, :session_token
    
    add_index :sessions, :user_id
    add_index :sessions, :token
  end
end
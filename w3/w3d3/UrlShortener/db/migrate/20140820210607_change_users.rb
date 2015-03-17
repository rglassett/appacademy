class ChangeUsers < ActiveRecord::Migration
    def up
      change_table :users do |t|
        remove_column :users, :email
        t.string :email, unique: true, null: false
      end
      add_index(:users, :email, unique: true)
    end
    
    def down
      change_table :users do |t|
        remove_column :users, :email
        t.string :email
      end
    end
end

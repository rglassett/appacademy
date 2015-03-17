class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_name, null: false
      t.timestamps
    end
    add_index(:users, :user_name, unique:true)
  end
end

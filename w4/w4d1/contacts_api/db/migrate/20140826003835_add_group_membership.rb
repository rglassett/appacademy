class AddGroupMembership < ActiveRecord::Migration
  def change
    create_table :group_memberships do |t|
      t.integer :contact_id, null: false
      t.integer :group_id, null: false
      
      t.timestamps
    end
    add_index :group_memberships, [:contact_id, :group_id], unique: true
  end
end

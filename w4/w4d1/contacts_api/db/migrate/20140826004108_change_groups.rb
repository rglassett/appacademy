class ChangeGroups < ActiveRecord::Migration
  def change
    remove_column :contact_groups, :group_id
    remove_column :contact_groups, :contact_id
  end
end

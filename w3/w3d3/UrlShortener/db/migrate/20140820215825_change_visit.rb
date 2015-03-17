class ChangeVisit < ActiveRecord::Migration
  def up
    change_table :visits do |t|
      remove_column :visits, :visitor
      remove_column :visits, :visited_url
      t.integer :visitor_id, null: false
      t.integer :url_id, null: false
    end
    add_index(:visits, :visitor_id)
    add_index(:visits, :url_id)
  end
  
  def down
    change_table :visits do |t|
      remove_column :visits, :visitor_id
      remove_column :visits, :visited_url
      t.string :visitor, null: false
      t.string :visited_url, null: false
    end
  end
end

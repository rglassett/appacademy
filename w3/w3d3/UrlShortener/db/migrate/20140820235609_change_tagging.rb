class ChangeTagging < ActiveRecord::Migration
  def change
    add_index :taggings, [:url_id, :tag_topic_id], unique: true
  end
end

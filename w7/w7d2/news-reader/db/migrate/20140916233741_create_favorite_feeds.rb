class CreateFavoriteFeeds < ActiveRecord::Migration
  def change
    create_table :favorite_feeds do |t|
      t.references :user, index: true
      t.references :feed, index: true

      t.timestamps
    end
    add_index :favorite_feeds, [:user_id, :feed_id], unique: true
  end
end

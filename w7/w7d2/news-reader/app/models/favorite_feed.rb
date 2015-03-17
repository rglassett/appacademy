class FavoriteFeed < ActiveRecord::Base
  validates :user_id, uniqueness: { scope: :feed_id }
  
  belongs_to :user
  belongs_to :feed
end

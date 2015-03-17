require 'open-uri'

class Feed < ActiveRecord::Base
  has_many :entries, :dependent => :destroy
  
  has_many(
    :likers,
    :class_name => "FavoriteFeed"
  )
  
  has_many :followers, :through => :likers, :source => :user
  
  def self.find_or_create_by_url(url)
    feed = Feed.find_by_url(url)
    return feed if feed

    begin
      feed_data = SimpleRSS.parse(open(url))
      feed = Feed.create!(title: feed_data.title, url: url)
      feed_data.entries.each do |entry_data|
        Entry.create_from_json!(entry_data, feed)
      end
    rescue SimpleRSSError
      return nil
    end

    feed
  end
  
  def latest_entries
    time_diff = Time.now - Time.parse(updated_at.to_s)
    if time_diff > 30
      reload
    end
    entries
  end

  def reload
    # reloads entries
    self.touch #this causes the updated_at column to be updated
    begin
      feed_data = SimpleRSS.parse(open(url))
      existing_entry_guids = Entry.pluck(:guid).sort
      feed_data.entries.each do |entry_data|
        unless existing_entry_guids.include?(entry_data.guid)
          Entry.create_from_json!(entry_data, self)
        end
      end

      self
    rescue SimpleRSSError
      return false
    end
  end
end

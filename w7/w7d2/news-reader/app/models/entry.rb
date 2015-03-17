class Entry < ActiveRecord::Base
  belongs_to :feed

  def self.create_from_json!(entryData, feed)
    scrub_encoding(entryData)

    Entry.create!({
      guid: entryData[:guid],
      link: entryData[:link],
      published_at: entryData[:pubDate],
      title: entryData[:title],
      json: entryData.to_json,
      feed_id: feed.id
    })
  end

  def self.scrub_encoding(data)
    data.each do |k, v|
      data[k] = v.is_a?(String) ? v.force_encoding("utf-8") : v
    end
  end
end

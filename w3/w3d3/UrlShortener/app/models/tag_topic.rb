class TagTopic < ActiveRecord::Base
  validates :tag_topic, presence: true, uniqueness: true
  
  def self.most_popular_topics(n) # Don't try to put ruby in your activerecord!
    TagTopic.joins(:taggings).
    group('tag_topics.id').
    order('COUNT(*) DESC').
    limit(n)
  end
  
  def num_taggings
    taggings.where('tag_topic_id = ?', id ).count
  end
  
  has_many(
    :taggings,
    class_name: 'Tagging',
    foreign_key: :tag_topic_id,
    primary_key: :id
  )
  
  has_many(
    :tagged_urls,
    through: :taggings,
    source: :shortened_url
  )
end
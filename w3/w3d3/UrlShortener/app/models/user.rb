class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  
  has_many(
    :shortened_urls,
    class_name: 'ShortenedUrl',
    foreign_key: :submitter_id,
    primary_key: :id
  )
  
  has_many(
    :visits,
    class_name: 'Visit',
    foreign_key: :visitor_id,
    primary_key: :id
  )
  
  has_many(
    :visited_urls,
    Proc.new { distinct },
    through: :visits,      # association defined in this class
    source: :shortened_url # association defined in the visit model
  )
end
class ShortenedUrl < ActiveRecord::Base
  validates :short_url, :long_url, presence: true, uniqueness: true, 
            length: { maximum: 1024 }
  validate :too_many_recent_submissions
  
  def too_many_recent_submissions
    if num_recent_submissions(submitter_id) > 5
      errors.add(:overflow, "Too many submissions in the last minute!")
    end
  end
   
  def self.random_code
    # Generate random 16 char code
    random_code = SecureRandom.urlsafe_base64(16)
    
    while ShortenedUrl.exists?(:short_url => random_code)
      random_code = SecureRandom.urlsafe_base64(16)
    end
    random_code
  end
  
  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedUrl.create!(
      short_url: random_code,
      long_url: long_url,
      submitter_id: user.id
    )
  end
  
  def num_clicks
    visits.count
  end
  
  def num_uniques
    visitors.count
  end
  
  def num_recent_uniques
     visits.where('created_at > ?', 15.minutes.ago ).distinct.count
  end
  
  def num_recent_submissions(submitter_id)
    ShortenedUrl.where('submitter_id = ? and created_at > ?', submitter_id, 1.minute.ago).count
  end
  
  belongs_to(
    :submitter,
    class_name: 'User',
    foreign_key: :submitter_id,
    primary_key: :id
  )
  
  has_many(
    :visits,
    class_name: 'Visit',
    foreign_key: :url_id,
    primary_key: :id
  )
  
  has_many(
    :visitors,
    Proc.new { distinct },
    through: :visits,
    source: :user
  )
  
  has_many(
    :taggings,
    class_name: 'Tagging',
    foreign_key: :url_id,
    primary_key: :id
  )
  
  has_many(
    :tag_topics,
    through: :taggings,
    source: :tag_topic
  )
end
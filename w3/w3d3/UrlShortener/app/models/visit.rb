class Visit < ActiveRecord::Base
  validates :visitor_id, :url_id, presence: true
  
  def self.record_visit!(user, shortened_url)
    # create a Visit Object recording a visit from user
    Visit.create!(
      visitor_id: user.id,
      url_id: shortened_url.id
    )
  end
  
  belongs_to(
    :user,
    class_name: 'User',
    foreign_key: :visitor_id,
    primary_key: :id
  )
  
  belongs_to(
    :shortened_url,
    class_name: 'ShortenedUrl',
    foreign_key: :url_id,
    primary_key: :id
  )
end
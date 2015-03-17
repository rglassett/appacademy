class User < ActiveRecord::Base
  validates :name, :session_token, presence: true, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :password_digest, presence: true
  
  after_initialize :ensure_session_token

  has_many(
    :favorite_feeds,
    :class_name => "FavoriteFeed"
  )
  
  has_many :liked_feeds, through: :favorite_feeds, :source => :feed
  
  def self.generate_session_token
    SecureRandom.urlsafe_base64
  end
  
  def self.find_by_credentials(username, password)
    user = self.find_by_name(username)
    if user && user.is_password?(password)
      return user
    end
    return nil
  end
  
  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end
  
  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
  end
  
  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end
  
  private
  attr_reader :password
end
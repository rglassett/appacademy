class User < ActiveRecord::Base
  include Commentable
  
  validates :username,
    :password_digest,
    :session_token,
    presence: true
  validates :username, :session_token, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }
  
  after_initialize :ensure_session_token
  
  has_many :goals, dependent: :destroy
  
  def self.generate_session_token
    SecureRandom.urlsafe_base64
  end
  
  def self.find_by_credentials(username, password)
    user = self.find_by_username(username)
    return nil unless user
    user if user.is_password?(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest) == password
  end
  
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def public_goals
    self.goals.where(private: false)
  end
  
  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
  end
  
  private
  
  attr_reader :password
  
  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end
  
end
class User < ActiveRecord::Base
  
  attr_reader :password
  
  validates :user_name, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }
  
  has_many(
    :cats,
    class_name: 'Cat',
    foreign_key: :user_id,
    primary_key: :id
  )
  
  has_many(
    :cat_rental_requests,
    class_name: 'CatRentalRequest',
    foreign_key: :user_id,
    primary_key: :id
  )
  
  has_many(
    :session_tokens,
    class_name: 'SessionToken',
    foreign_key: :user_id,
    primary_key: :id,
    dependent: :destroy
  )
  
  def self.find_by_credentials(user_name, password)
    user = User.where(user_name: user_name).first
    return nil unless user && user.is_password?(password)
    user
  end
  
  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end
  
  def password=(new_password)
    @password = new_password
    self.password_digest = BCrypt::Password.create(new_password)
  end
end

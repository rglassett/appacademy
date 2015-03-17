class Session < ActiveRecord::Base
  
  validates :user_id, :token, presence: true
  
  before_validation :assign_token!
  
  belongs_to(
    :user,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id
  )
  
  def assign_token!
    self.token = SecureRandom.base64(16)
  end

end
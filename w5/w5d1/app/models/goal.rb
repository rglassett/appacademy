class Goal < ActiveRecord::Base
  include Commentable
  
  validates :user_id, :description, presence: true
  validates :private, :completed, inclusion: [true, false]
  
  after_initialize :default_to_public
  
  belongs_to :user

  def self.all_public
    self.where(private: false)
  end
  
  def default_to_public
    self.private ||= false
  end
  
end
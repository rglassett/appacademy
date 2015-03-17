# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  email      :string(255)      not null
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Contact < ActiveRecord::Base
  validates :user_id, :name, :email, presence: true
  validates :user_id, uniqueness: { scope: :email }
  
  belongs_to(
    :owner,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id
  )
  
  has_many :contact_shares
  
  has_many(
    :shared_users,
    through: :contact_shares,
    source: :user
  )
  
  has_many :comments, :as => :commentable
  
  has_many :contact_groups
end

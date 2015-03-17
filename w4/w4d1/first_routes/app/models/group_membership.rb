# == Schema Information
#
# Table name: group_memberships
#
#  id         :integer          not null, primary key
#  contact_id :integer          not null
#  group_id   :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class GroupMembership < ActiveRecord::Base
  validates :contact_id, :group_id, presence: true
  validates :contact_id, uniqueness: { scope: :group_id }
  
  belongs_to :contact
  
  belongs_to(
    :group,
    class_name: 'ContactGroup',
    foreign_key: :group_id,
    primary_key: :id
  )
end
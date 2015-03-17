# == Schema Information
#
# Table name: contact_groups
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class ContactGroup < ActiveRecord::Base
  belongs_to(
    :owner,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id
  )
  
  has_many(
    :group_memberships,
    class_name: 'GroupMembership',
    foreign_key: :group_id,
    primary_key: :id, dependent: :destroy
  )
  
  has_many(
    :contacts,
    through: :group_memberships,
    source: :contact
  )
end
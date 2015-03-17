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

require 'test_helper'

class GroupMembershipTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

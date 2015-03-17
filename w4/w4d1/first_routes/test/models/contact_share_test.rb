# == Schema Information
#
# Table name: contact_shares
#
#  id         :integer          not null, primary key
#  contact_id :integer          not null
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class ContactShareTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

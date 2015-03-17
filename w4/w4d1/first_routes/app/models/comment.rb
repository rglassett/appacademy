# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  content          :text             not null
#  commentable_id   :integer          not null
#  commentable_type :string(255)      not null
#  created_at       :datetime
#  updated_at       :datetime
#

# commentable type must be "User" or "Contact"

class Comment < ActiveRecord::Base
  validates :content, :commentable_id, :commentable_type, presence: true
  
  belongs_to :commentable, :polymorphic => true, inverse_of: :comments
  # How does this associate with shared contacts?
end
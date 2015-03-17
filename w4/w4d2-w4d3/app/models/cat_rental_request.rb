# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class CatRentalRequest < ActiveRecord::Base
  
  validates :cat_id, :start_date, :end_date, :user_id, presence: true
  validates :status, inclusion: { in: ["PENDING", "APPROVED", "DENIED"] }
  
  validate :request_does_not_conflict_with_others
  
  after_initialize do |cat_rental|
    cat_rental.status ||= "PENDING" 
  end
  
  belongs_to(
    :cat,
    class_name: 'Cat',
    foreign_key: :cat_id,
    primary_key: :id
  )
  
  belongs_to(
    :user,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id
  )
  
  def overlapping_requests

    where_clause = <<-SQL
      ((start_date BETWEEN '#{start_date}' AND '#{end_date}') OR
      (end_date BETWEEN '#{start_date}' AND '#{end_date}')) OR
      (('#{start_date}' BETWEEN start_date AND end_date) OR
      ('#{end_date}' BETWEEN start_date AND end_date))
    SQL
    
    CatRentalRequest.where(:cat_id => cat_id)
      .where(where_clause)
      .where.not(:id => id)
  end
  
  def overlapping_approved_requests
    overlapping_requests.where(:status => "APPROVED" )
  end
  
  def pending?
    status == "PENDING"
  end
  
  def request_does_not_conflict_with_others
    if overlapping_approved_requests.exists? && self.status == "APPROVED"
      errors[:cat_id] << "already requested"
    end
  end
  
  def overlapping_pending_requests
    overlapping_requests.where(:status => "PENDING" )
  end
  
  def approve!
    self.status = "APPROVED"
    if self.save
      self.overlapping_pending_requests.update_all(:status => "DENIED")
    else
      errors[:cat_id] << "overlaps with another request!"
    end
  end
  
  def deny!
    self.update(:status => "DENIED")
  end
end

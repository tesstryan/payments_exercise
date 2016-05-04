class Payment < ActiveRecord::Base

  validates :amount, presence: true
  validates :loan_id, presence: true

  belongs_to :loan

end

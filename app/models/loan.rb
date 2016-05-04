class Loan < ActiveRecord::Base

  has_many :payments

  before_create :set_outstanding_balance # will initially equal the funded_amount

  private

  def set_outstanding_balance
    self.outstanding_balance = self.funded_amount
  end

end

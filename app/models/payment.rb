class Payment < ActiveRecord::Base

  belongs_to :loan

  validates :amount, presence: true
  validates :loan_id, presence: true

  validate :check_remaining_balance, :if => lambda { |p| p.amount? && p.loan_id? }

  def check_remaining_balance
    @loan = self.loan
    @payment_amount = BigDecimal(self.amount)
    @outstanding = BigDecimal(@loan.outstanding_balance)

    if @payment_amount > @outstanding
      errors.add(:amount, :amount_exceeds_balance)
    else
      @loan.update_attributes!(outstanding_balance: @outstanding - @payment_amount)
    end
  end

end

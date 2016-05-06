class Payment < ActiveRecord::Base

  belongs_to :loan

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :loan_id, presence: true, numericality: { only_integer: true }

  validate :check_remaining_balance, :if => Proc.new { |p| p.errors.empty? }

  def check_remaining_balance
    if self.loan
      @loan = self.loan
      @payment_amount = BigDecimal(self.amount)
      @outstanding = BigDecimal(@loan.outstanding_balance)

      if @payment_amount > @outstanding
        errors.add(:amount, "exceeds outstanding balance")
      else
        @loan.update_attributes!(outstanding_balance: @outstanding - @payment_amount)
      end
    else
      errors.add(:loan_id, "not found")
    end
  end

end

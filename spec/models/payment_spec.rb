require 'rails_helper'

RSpec.describe Payment, type: :model do
  let(:loan) { Loan.create!(funded_amount: 100.0) }

  it "is invalid without a amount" do
    payment = Payment.new(amount: nil, loan_id: loan.id )
    payment.valid?
    expect(payment.errors[:amount]).to include("can't be blank")
  end

  it "is invalid without a loan id" do
    payment = Payment.new(amount: 50.0, loan_id: nil )
    payment.valid?
    expect(payment.errors[:loan_id]).to include("can't be blank")
  end

end

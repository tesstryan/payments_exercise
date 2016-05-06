require 'rails_helper'

RSpec.describe Payment, type: :model do
  let(:loan) { Loan.create!(funded_amount: 100.0) }

  it "is invalid without a amount" do
    payment = Payment.new(amount: nil, loan_id: loan.id )
    payment.valid?
    expect(payment.errors[:amount]).to include("can't be blank")
  end

  it "is invalid with an amount of zero" do
    payment = Payment.new(amount: 0, loan_id: loan.id )
    payment.valid?
    expect(payment.errors[:amount]).to include("must be greater than 0")
  end

  it "is invalid without a loan id" do
    payment = Payment.new(amount: 50.0, loan_id: nil )
    payment.valid?
    expect(payment.errors[:loan_id]).to include("can't be blank")
  end

  it "is invalid if the amount exceeds outstanding balance" do
    payment = Payment.new(amount: 200.0, loan_id: loan.id )
    payment.valid?
    expect(payment.errors[:amount]).to include("exceeds outstanding balance")
  end

  it "deducts the amount from outstanding balance if valid" do
    payment = Payment.new(amount: 50.50, loan_id: loan.id )
    payment.valid?
    expect(payment.loan.outstanding_balance).to eq(49.50)
  end

end

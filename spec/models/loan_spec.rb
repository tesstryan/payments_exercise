require 'rails_helper'

RSpec.describe Loan, type: :model do

  it "has an outstanding_balance when created" do
    loan = Loan.create!(funded_amount: 200.0)
    expect(loan.outstanding_balance).to eq(200.0)
  end

end

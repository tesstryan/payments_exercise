10.times { Loan.create!(funded_amount: rand(10-1000).to_f) }

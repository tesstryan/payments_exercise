api development practice exercise

Rake db:seed to get a example loans in your database. 
Add payments with: POST /loans/:loan_id/payments 
To see all payments for a specific loan: GET /loans/:loan_id/payments
To see a specific payment: GET /loans/:loan_id/payments/:id 
If a payment is successfully made, it will be subtracted from the outstanding balance on the corresponding loan. 
A payment cannot be made if it exceeds the outstanding balance of the loan. 
The outstanding balance can be seen with GET /loans or GET /loans/:id.  





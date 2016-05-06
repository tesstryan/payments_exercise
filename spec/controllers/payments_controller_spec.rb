require 'rails_helper'

RSpec.describe PaymentsController, type: :controller do
  let(:loan) { Loan.create!(funded_amount: 100.0) }

  describe '#index' do
    it 'responds with a 200' do
      get :index, loan_id: loan.id
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#create' do
    it 'creates payment and responds with a 201' do
      post :create, { amount: 10.0, loan_id: loan.id }
      expect(response).to have_http_status(:created)
    end

    it 'does not create a payment that is not valid' do
      post :create, { loan_id: loan.id }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe '#show' do
    let(:payment) { Payment.create!(loan_id: loan.id, amount: 100.0)}

    it 'responds with a 200' do
      get :show, id: payment.id, loan_id: loan.id
      expect(response).to have_http_status(:ok)
    end

    context 'if the payment is not found' do
      it 'responds with a 404' do
        get :show, id: 10000, loan_id: loan.id
        expect(response).to have_http_status(:not_found)
      end
    end
  end

end

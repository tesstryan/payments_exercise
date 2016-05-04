class PaymentsController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: 'not_found', status: :not_found
  end

  def index
    render json: Payment.where(loan_id: params[:loan_id])
  end

  def create
    @payment = Payment.create!(payment_params)
    render status: :created, json: @payment
  end

  def show
    render json: Payment.find(params[:id])
  end


private

def payment_params
  params.permit(:amount, :loan_id)
end

end

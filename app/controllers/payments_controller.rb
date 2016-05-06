class PaymentsController < ApplicationController

  protect_from_forgery :except => [:create]

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: 'not_found', status: :not_found
  end

  def index
    render json: Payment.where(loan_id: params[:loan_id])
  end

  def create
    @payment = Payment.new(payment_params)
    if @payment.save
      render status: :created, json: @payment
    else
      render status: :unprocessable_entity, json: { :errors => @payment.errors.full_messages }
    end
  end

  def show
    render json: Payment.find(params[:id])
  end


private

def payment_params
  params.permit(:amount, :loan_id)
end

end

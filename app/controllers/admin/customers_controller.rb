class Admin::CustomersController < ApplicationController
  def index
    @customers = customer_session
  end
  
  def show
  end
  
  def edit
  end
  
  def update
  end
  
  private
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :phone_number, :email, :is_customer_status)
  end
end

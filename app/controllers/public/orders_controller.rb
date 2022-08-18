class Public::OrdersController < ApplicationController
  
  def new
    @cart_items = CartItem.where(customer_id:[current_customer.id])
    @order_information = OrderInformation.new
    @addresses = Address.where(customer_id:[current_customer.id])
  end
  
  def confirm
    @cart_items = CartItem.where(customer_id:[current_customer.id])
    @order_information = OrderInformation.new
    @addresses = Address.where(customer_id:[current_customer.id])
    @postage = 800
    session[:user] = OrderInformation.new()
    #配送先
     if params[:address_select] == "0"
      session[:user][:shipping_postal_code] = current_customer.postal_code
      session[:user][:shipping_address] = current_customer.address
      session[:user][:shipping_name] = current_customer.name
    elsif params[:address_select] == "1"
      session[:user][:shipping_postal_code] = Address.find(params[:address_id]).postal_code
      session[:user][:shipping_address] = Address.find(params[:address_id]).address
      session[:user][:shipping_name] = Address.find(params[:address_id]).name
    else 
      session[:user][:shipping_postal_code] =  params[:shipping_postal_code]
      session[:user][:shipping_address] = params[:shipping_address]
      session[:user][:shipping_name] = params[:shipping_name]  
    end
  end
  
  def complete
  end
  
  def create
  end
  
  def index
  end
  
  def show
  end 
  
private

  def order_params
    params.require(:order).permit(:shipping_name, :shipping_postal_code, :shipping_address, :method_of_payment, :customer_id)
  end
  
end  

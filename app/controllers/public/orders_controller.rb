class Public::OrdersController < ApplicationController
  before_action :order_is_valid,only:[:new, :confirm, :create]
  
  def new
    @cart_items = CartItem.where(customer_id:[current_customer.id])
    @addresses = Address.where(customer_id:[current_customer.id])
  end
  
  def confirm
    @cart_items = current_customer.cart_items
    @postage = 800
  end
  
  def complete
  end
  
  def create
     session[:user] = Order.new()

    #支払い方法のセッション情報
    if params[:method_of_payment_select] == "0"
      session[:user][:method_of_payment] = 0
    elsif params[:method_of_payment_select] == "1"
      session[:user][:method_of_payment] = 1
    end
    
    #配送先登録のセッション情報
    if params[:address_select] == "0"
      session[:user][:shipping_postal_code] = current_customer.postal_code
      session[:user][:shipping_address] = current_customer.address
      session[:user][:shipping_name] = current_customer.full_name
    elsif params[:address_select] == "1"
      session[:user][:shipping_postal_code] =  Address.find(params[:address_id]).postal_code
      session[:user][:shipping_address] = Address.find(params[:address_id]).address
      session[:user][:shipping_name] = Address.find(params[:address_id]).name
    else 
      session[:user][:shipping_postal_code] =  params[:shipping_postal_code]
      session[:user][:shipping_address] = params[:shipping_address]
      session[:user][:shipping_name] = params[:shipping_name]
    end
    redirect_to orders_confirm_path
    
  end
  
  def index
  end
  
  def show
  end 
  
private

  def order_params
    params.require(:order).permit(:shipping_name, :shipping_postal_code, :shipping_address, :method_of_payment, :customer_id)
  end 
  
  def order_is_valid
      @cart_items = CartItem.where(customer_id:[current_customer.id])
      if @cart_items.present? == false
         redirect_to root_path
      end
  end
end  

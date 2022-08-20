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
    #支払方法
     if params[:method_of_payment_select] == "0"
      session[:user][:method_of_payment] = 0
     elsif params[:method_of_payment_select] == "1"
      session[:user][:method_of_payment] = 1
     end
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
    order_information = OrderInformation.new(session[:user])
    order_information.customer_id = current_customer.id
    order_information.save
    cart_items = current_customer.cart_items
    @cart_items.each do |cart_item|
      ordered_item = OrderedItem.new
      ordered_item.item_id = cart_item.item.id
      ordered_item.status = 0
      ordered_item.price = cart_item.item.add_tax_price
      ordered_item.quantity = cart_item.amount
      ordered_item.order_id = order.id
      ordered_item.save
    end
    @cart_items.destroy_all
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

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
  end
  
  def create
     @cart_items = CartItem.where(customer_id:[current_customer.id])
     @order_information = OrderInformation.new(session[:user])
     @order_information.postage = 800
     @order_informations.billing_amount = 0
     @order_information.customer_id = current_customer.id
     @order_information.save
    # 以下、order_detail作成
		 @cart_items = current_customer.cart_items
		 @cart_items.each do |cart_item|
			@ordered_product = OrderedProduct.new
			@ordered_product.order_information_id = @order_information.id
			@ordered_product.item_id = cart_item.item.id
			@ordered_product.amount = cart_item.amount
			@ordered_product.making_status = 0
			@ordered_product.price = cart_item.item.add_tax_price
			@ordered_product.save
		end

		# 購入後はカート内商品削除
		@cart_items.destroy_all
		redirect_to orders_complete_path
		end

		
  
  def index
    @order_informations = OrderInformation.where(customer_id:[current_customer.id])
    @ordered_products = OrderedProduct.where(customer_id:[current_customer.id])
  end
  
  def show
  end 
  
private

  def order_information_params
    params.require(:order_information).permit(:shipping_name, :shipping_postal_code, :shipping_address, :method_of_payment, :customer_id)
  end
  
end  

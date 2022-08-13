class Public::OrdersController < ApplicationController
  def new
    @cart_items = CartItem.where(customer_id:[current_customer.id])
    @addresses = Address.where(customer_id:[current_customer.id])
  end
  
  def confirm
  end
  
  def complete
  end
  
  def create
  end
  
  def index
  end
  
  def show
  end 
end  

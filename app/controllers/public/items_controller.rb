class Public::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page]).per(8)
  end
  
  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    if customer_signed_in?
        @cart_items = CartItem.where(customer_id:[current_customer.id])
    end
  end  
end

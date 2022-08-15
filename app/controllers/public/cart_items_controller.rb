class Public::CartItemsController < ApplicationController
  def index
     @cart_items = current_customer.cart_items
     @total_price = @cart_items.sum{|cart_item|cart_item.item.add_tax_price * cart_item.amount }
     # sumメソッド：合計金額を出す
        # 1行目の@cart_itemsにsumメソッドを用いて{}の||ブロック変数にcart_itemを代入している。(each do || end の文章と同じイメージ)
        # cart_item.item.add_tax_price：アソシエーションしているのでドットでつなげる。
        # 『このcart_itemのitemのadd_tax_price』 → 『このカート商品の商品の税込価格』
        # cart_item.amount：『このカート商品の個数』
  end
  
  def update
    @cart_item = CartItem.find(params[:id])
    #@cart.units += cart_params[:units].to_i
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end
  
  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end
  
  def destroy_all
    @cart_item = current_customer.cart_items
    @cart_item.destroy_all
    redirect_to cart_items_path
  end
  
  def create
     @cart_item = CartItem.new(cart_item_params)
      @cart_item.customer_id = current_customer.id
     @cart_item.item_id = params[:item_id]
		 @cart_item.save
		 redirect_to '/cart_items'
  end
  
   private
   
  def cart_item_params
        params.require(:cart_item).permit(:amount, :item_id, :customer_id)
  end
end

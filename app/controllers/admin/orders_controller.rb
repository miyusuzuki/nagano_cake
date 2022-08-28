class Admin::OrdersController < ApplicationController
  def show
    @order_information = OrderInformation.find(params[:id])
    @ordered_products = OrderedProduct.all
  end
  
  def update
    @order_information = OrderInformation.find(params[:id])
    @order_information.update(order_params)
    if params[:order][:status] == "入金確認"
         @ordered_products.each do |ordered_products|
            ordered_products.update!(create_status: 1)
         end
    end
      redirect_to admin_order_path(@order)
  end
  
  private
   def order_params
      params.require(:order).permit(:customer_id, :shipping_postal_code, :shipping_address, :shipping_name, :method_of_payment, :status, :postage, :billing_amount)
   end

end

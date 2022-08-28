class Admin::HomesController < ApplicationController
  def top
    @order_informations = OrderInformation.all
    @ordered_products = OrderedProduct.all
  end  
end

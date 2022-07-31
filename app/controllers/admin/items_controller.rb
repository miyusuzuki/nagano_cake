class Admin::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page])
  end
  
  def new
    @item = Item.new
  end
  
  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_items_path
    else
      render :new
    end
  end
  
  def show
    @item = Item.find(params[:id])
    @genre = Genre.find(@item.genre_id)
  end
  
  def edit
  end
  
  def update
  end
  
  private
  def item_params
    params.require(:item).permit(:name, :genre_id, :price, :is_active, :image, :introduction)
  end
  def params_genre
    params.require(:genre).permit(:name, :status)
  end
end

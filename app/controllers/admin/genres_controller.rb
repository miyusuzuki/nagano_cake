class Admin::GenresController < ApplicationController
  def index
    @genre = Genre.new
  	@genres = Genre.all
  end
  
  def create
    @genre = Genre.new(params_genre)
  	if @genre.save
  		redirect_to admin_genres_path
  	else
  		@genres = Genre.all
  		render "admin/genres/index"
  	end
  end
  
  def edit
    @genre = Genre.find(params[:id])
  end
  
  def update
    @genre = Genre.find(params[:id])
    if @genre.update(params_genre)
        
      redirect_to admin_genres_path
    else
      render "admin/genres/edit"
    end
  end
  
  private
  def params_genre
    params.require(:genre).permit(:name, :status)
  end
end

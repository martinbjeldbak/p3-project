class FavoritesController < ApplicationController
  def index 
	@favs = logged_in? ? current_user.favorites : nil
	#TODO: read cookie
  end
  
  
  def add
	if logged_in?
      if current_user.favorites.find_by_id(params[:id])
        return redirect_to :favorites
      end
      recipe = Recipe.find_by_id(params[:id])
      if recipe
        current_user.favorites << recipe
        recipe.rating = recipe.rating ? (recipe.rating + 1) : 1
        recipe.save
        return respond_to do |format|
          format.html do
            redirect_to :favorites
          end
          format.json do
            render json: recipe 
          end
        end
      end
	end
    redirect_to :favorites
  end
  
  def remove
	if logged_in?
      fav = current_user.favorites.find_by_id(params[:id])
      if fav
        fav.rating = fav.rating ? (fav.rating > 0 ? fav.rating - 1 : 0) : 0
        fav.save
        current_user.favorites.delete(fav)
        return respond_to do |format|
          format.html do
            redirect_to :favorites
          end
          format.json do
            render json: true
          end
        end
      end
	end
	redirect_to :favorites
  end
  
end

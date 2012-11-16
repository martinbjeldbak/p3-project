class FavoritesController < ApplicationController
  def index 
	@favs = signed_in? ? current_user.favorites : nil
	#TODO: read cookie
  end
  
  
  def add
	if signed_in?
		recip = Recipe.find_by_id( params[:id] )
		if recip
			current_user.favorites<<recip
		end
	end
	redirect_to :favorites
  end
  
  def remove
	if signed_in?
		fav = current_user.favorites.find_by_id( params[:id] )
		if fav
			fav.destroy
		end
	end
	redirect_to :favorites
  end
  
end

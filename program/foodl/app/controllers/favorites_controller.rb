class FavoritesController < ApplicationController
  def index
		if logged_in?
			@favs = current_user.favorites
		else
			@favs = session[:favored].nil? ? nil : Recipe.find( session[:favored] )
		end
  end
  
  
  def add
	  was_added = false
		
    if logged_in?
      #Don't add if it already is favorized
      if !current_user.favorites.find_by_id(params[:id])
				#NOTE: this is replicated in users_controller!
				recipe = Recipe.find_by_id(params[:id]) #TODO: what is the difference between the two calls?
				if recipe
					#Add recipe to user
					current_user.favorites << recipe
					was_added = true
					
					#Increase rating of recipe
					recipe.rating = recipe.rating ? (recipe.rating + 1) : 1
					recipe.save
				end
      end
    else
      #Save in session
      session[:favored] ||= []
			if !session[:favored].include?(params[:id])
				session[:favored] << params[:id]
				was_added = true
				#Do not modify rating, as it could mess things up if cookies are deleted or stuff
			end
    end
    
		#Act
		if was_added
			#Send response if requested by AJAX
			return respond_to do |format|
				format.html do
					redirect_to :favorites
				end
				format.json do
					render json: recipe 
				end
			end
		else
			#Just go back to favorites
			redirect_to :favorites
		end
	end
  
		#Act
  def remove
    was_removed = false
		if logged_in?
      fav = current_user.favorites.find_by_id(params[:id])
      if fav
        fav.rating = fav.rating ? (fav.rating > 0 ? fav.rating - 1 : 0) : 0
        fav.save
        current_user.favorites.delete(fav)
				was_removed = true
      end
		else
			#Remove from session
			index = session[:favored].nil? ? nil : session[:favored].index(params[:id])
			if index
				session[:favored].delete(params[:id])
				was_removed = true
			end
    end
		
		if was_removed
			return respond_to do |format|
				format.html do
					redirect_to :favorites
				end
				format.json do
					render json: true
				end
			end
		else
			redirect_to :favorites
		end
  end
  
end

class RecipesController < ApplicationController
  def picture
    recipe = Recipe.find(params[:id])
    response.headers['Cache-Control'] = "public, max-age=#{12.hours.to_i}"
    response.headers['Content-Type'] = 'image/jpeg'
    response.headers['Content-Disposition'] = 'inline'
    render :text => recipe.picture
  end
end

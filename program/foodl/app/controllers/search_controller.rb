class SearchController < ApplicationController
  def index
  end

  def result
  end

  def autocomplete_food_types
    types = FoodType.where("name LIKE ?", "%" + params[:q] + "%");
    render :json => types
  end
end

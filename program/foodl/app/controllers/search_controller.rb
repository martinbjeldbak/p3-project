class SearchController < ApplicationController
  def index
  end

  def result
  end

  def autocomplete_food_types
    names = FoodType.select(:name)
      .where("name LIKE ?", "%" + params[:q] + "%")
      .limit(5)
      .pluck(:id)
    render :json => names
  end
end

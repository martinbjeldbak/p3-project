class SearchController < ApplicationController
  def index
  end

  def result
  end

  def autocomplete_food_types
    names = FoodType.select(:name)
      .where("name LIKE ?", "%" + params[:q] + "%")
      .order("case when name LIKE '%tomat%' then 1 else 0 end DESC")
      .limit(5)
      .pluck(:id)
    render :json => names
  end
end

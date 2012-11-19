class SearchController < ApplicationController
  def index
  end

  def result
  end

  def autocomplete_food_types
    query = "%" + params[:q] + "%"
    orderBy = FoodType.send(
      :sanitize_sql_array,
      ["case when name LIKE ? then 1 else 0 end DESC", query]
    )
    names = FoodType.select(:name)
      .where("name LIKE ?", query)
      .order(orderBy)
      .limit(5)
      .pluck(:name)
    render :json => names
  end
end

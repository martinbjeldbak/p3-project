class SearchController < ApplicationController
  def index
  end

  def result
    querystring = params[:q]
    names = querystring.split '|'
    if names.empty?
      redirect_to :root
    end
    sql = "SELECT * FROM recipes WHERE id IN ("
    sql += "SELECT recipe_id FROM ingredients WHERE food_type_id IN ("
    sql += "SELECT id FROM food_types WHERE"
    first = true
    for name in names
      if first
        first = false
      else
        sql += ' OR'
      end
      sql += ' name = ' + Recipe.connection.quote(name)
    end
    sql += '))'
    firebug "SQL: " + sql
    @recipes = Recipe.find_by_sql(sql)
    firebug "Results: " + @recipes.length.to_s
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

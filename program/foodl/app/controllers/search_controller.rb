class SearchController < ApplicationController
  def index
  end

  def result
    querystring = params[:q]
    if !querystring 
      return redirect_to :root
    end
    names = querystring.split '|'
    if names.empty?
      return redirect_to :root
    end
#SELECT recipes.*, COUNT(*) as reccount FROM ingredients RIGHT JOIN recipes ON recipe_id = recipes.id WHERE food_type_id IN (SELECT id FROM food_types WHERE name = "havregryn" OR name = "bagepulver" OR name = "hvedemel") GROUP BY recipes.id ORDER BY reccount DESC
    sql = "SELECT recipes.*, COUNT(*) as relevance FROM ingredients"
    sql += " RIGHT JOIN recipes ON recipe_id = recipes.id"
    sql += " WHERE food_type_id IN (SELECT id FROM food_types WHERE ("
    first = true
    for name in names
      if first
        first = false
      else
        sql += ' OR'
      end
      sql += ' name = ' + Recipe.connection.quote(name)
    end
    sql += ')) GROUP BY recipes.id ORDER BY relevance DESC'
    firebug "SQL: " + sql
    @recipes = Recipe.find_by_sql(sql)
    firebug "Results: " + @recipes.length.to_s
    if @recipes[0]
      firebug @recipes[0].relevance.to_s
    end
  end

  def autocomplete_food_types
    orderBy = FoodType.send(
      :sanitize_sql_array,
      ["case when name LIKE ? then 1 else 0 end DESC", params[:q] ]
    )
    names = FoodType.select(:name)
      .where("name LIKE ?", "%" + params[:q] + "%")
      .order(orderBy)
      .limit(5)
      .pluck(:name)
    render :json => names
  end
end

class SearchController < ApplicationController

  include RecipesHelper

  def index
  end

  def result
    querystring = params[:q]
    restrictions = params[:r].to_i
    if !querystring 
      return redirect_to :root
    end
    names = querystring.split '|'
    if names.empty?
      return redirect_to :root
    end
#SELECT recipes.*, COUNT(*) as reccount FROM ingredients RIGHT JOIN recipes ON recipe_id = recipes.id WHERE food_type_id IN (SELECT id FROM food_types WHERE name = "havregryn" OR name = "bagepulver" OR name = "hvedemel") GROUP BY recipes.id ORDER BY reccount DESC
    sql = "SELECT * FROM food_types WHERE name in ("
    names.map! do |name|
      name = Recipe.connection.quote(name)
    end
    sql += names.join ", "
    sql += ")"
    @food_types = FoodType.find_by_sql(sql)
    sql = "SELECT recipes.*, COUNT(*) as relevance FROM ingredients"
    sql += " RIGHT JOIN recipes ON recipe_id = recipes.id"
    sql += " WHERE food_type_id IN ("
    sql += @food_types.map { |type| type.id }.join ", "
    sql += ')'
    if restrictions != 0 and restrictions != 7
      sql += ' AND ('
      restrictionSql = []
      if restrictions & 1 != 0
        restrictionSql << 'recipes.prep_time < 30'
      end
      if restrictions & 2 != 0
        restrictionSql << '(recipes.prep_time >= 30 AND recipes.prep_time <= 60)'
      end
      if restrictions & 4 != 0
        restrictionSql << 'recipes.prep_time > 60'
      end
      sql += restrictionSql.join " OR "
      sql += ')'
    end
    sql += ' GROUP BY recipes.id ORDER BY relevance DESC LIMIT 0, 50'
    firebug "SQL: " + sql
    @recipes = Recipe.find_by_sql(sql)
    firebug "Results: " + @recipes.length.to_s
    if @recipes[0]
      firebug @recipes[0].relevance.to_s
      firebug "max rating: " + max_rating.to_s
      firebug "0 rating: " + @recipes[0].calculate_rating.to_s
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

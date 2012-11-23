module RecipesHelper
  def max_rating
    @max_rating ||= ActiveRecord::Base.connection.select_one("SELECT MAX(rating) AS max_rating FROM recipes")['max_rating']
  end
end

#This script will go through all foodl.ingredients
#For each ingredient, it will find the best matching foodl.food_type and change its relationship.


class IngredientRemapper
require "rubygems"

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }


@@ingredients = []

def self.load_ingredients_from_db
	res = @@db.query("select `id`, `name` from `foodl`.`ingredients`")
	res.each do |row|
	ingredient_id = row[0]
		name = row[1].force_encoding("UTF-8")
		ingredients << [ingredient_id, name]
	end
end

def self.RemapAll
	FoodTypes.LoadFoodTypesFromDB()
	load_ingredients_from_db()
	ingredients.each do |ing|
		result = 
	end
end

end #end of class



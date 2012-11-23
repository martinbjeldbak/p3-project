#This script will go through all foodl.ingredients
#For each ingredient, it will find the best matching foodl.food_type and change its relationship.


class IngredientRemapper
	require "rubygems"

	Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }

	DB.Connect() #connects to foodl database

	@@ingredients = []

	def self.load_ingredients_from_db   #Only remap ingredients with match = -1
		puts "Loading ingredients from db"
		res = DB.Get.query("select `id`, `name` from `foodl`.`ingredients` WHERE `match` = '-1'")
		res.each do |row|
			ingredient_id = row[0]
			name = row[1].force_encoding("UTF-8")
			@@ingredients << [ingredient_id, name]
		end
		puts "Found " + @@ingredients.length.to_s + " ingredients to remap"
	end

	def self.update_ingredient(ing_id, food_type_id, match_percent)
		q = "UPDATE `foodl`.`ingredients` SET `food_type_id` = '" + food_type_id.to_s + "', `match` = '"+match_percent.to_s+"' WHERE `id` = '"+ing_id.to_s+"'"
		DB.Get.query(q)
	end

end #end of class

FoodTypes.LoadFoodTypesFromDB()
puts "Food types loaded: " + FoodTypes.Get.length.to_s
load_ingredients_from_db()
count = 0
@@ingredients.each do |ing|
	ing_id = ing[0]
	ing_name = ing[1]
	map = IngredientMapper.Map(ing[1])   #returns best matching food_type as [food_type_id, match_percent, name]
	food_type_id = map[0]
	match_percent = map[1]
	update_ingredient(ing_id, food_type_id, match_percent)
	count += 1
	puts "Remapped " + count.to_s + " of " + @@ingredients.length.to_s + " ingredients"
end
puts "Finished remapping a total of " + @@ingredients.length.to_s + " ingredients"

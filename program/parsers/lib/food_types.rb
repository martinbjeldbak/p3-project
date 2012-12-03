#Loads all the foodl.food_types from DB 
#Provides the method GetFoodTypes() that return all food types as an array of [name, db_id]

class FoodTypes
	require "mysql"
	@@foods = [] #contains elements from database table food_types [name, id]
	def self.LoadFoodTypesFromDB
		res = DB.Get.query("select `name`, `id` from `foodl`.`food_types`")
		res.each do |row|
			@@foods << [row[0].force_encoding("UTF-8"), row[1]]
		end
	end
	def self.print_food_table() #Print the food_types table so we can check if all food types have been loaded from database correctly
		@@foods.each do |s|
			puts s[0].force_encoding("UTF-8") +" : " + s[1].to_s   #outputs name : id
		end
	end
	def self.Get
		return @@foods
	end
	#print_food_table() #prints the food table
end #end of class




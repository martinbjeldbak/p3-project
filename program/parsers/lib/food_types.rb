#Loads all the foodl.food_types from DB 
#Provides the method GetFoodTypes() that return all food types as an array of [name, db_id]


class FoodTypes

require "mysql"

@@foods = [] #contains elements from database table food_types [name, id]

@@db = Mysql.init
@@db.options(Mysql::SET_CHARSET_NAME, 'utf8')
@@db.real_connect('198.175.125.69', 'foodl', 'foodl4321', 'foodl')
@@db.query("SET NAMES utf8")

def self.LoadFoodTypesFromDB
	res = @@db.query("select `name`, `id` from `foodl`.`ingredients`")
	res.each do |row|
		@@foods << [row[0].force_encoding("UTF-8"), row[1]]
	end
end

def self.print_food_table()
	@@foods.each do |s|
		puts s[0].force_encoding("UTF-8") +" : " + s[1].to_s   #outputs name : id
	end
end

def self.Get
	return @@foods
end

load_food_from_db() #loads food_types from database
#print_food_table() #prints the food table

end #end of class




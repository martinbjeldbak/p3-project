require "rubygems"

Dir[File.dirname(__FILE__) + '../lib/*.rb'].each {|file| require file }

DB.Connect() #connects to foodl database

FoodTypes.LoadFoodTypesFromDB()

IngredientMapper.Test()
require "rubygems"
require "nokogiri"
require "open-uri"

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }

FoodTypes.LoadFoodTypesFromDB() #Loads data from DB table foodl.food_types
#links = findRecipeLinks(57) #search arla.dk for recipe links, start from page 57
links = ArlaRecipeLinks.Get()
parseRecipes(links)
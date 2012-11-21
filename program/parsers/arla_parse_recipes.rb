require "rubygems"
require "nokogiri"
require "open-uri"

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }

DB.Connect() #makes connection to foodl database
FoodTypes.LoadFoodTypesFromDB() #Loads data from DB table foodl.food_types
#links = findRecipeLinks(57) #search arla.dk for recipe links, start from page 57
links = ArlaRecipeLinks.Get() #use the locally stored recipe links to not overload Arla's server
parseRecipes(links)
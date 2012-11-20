require "rubygems"
require "nokogiri"
require "open-uri"

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }


#links = findRecipeLinks(57) #search arla.dk for recipe links, start from page 57
links = ArlaRecipeLinks.Get
parseRecipes(links)
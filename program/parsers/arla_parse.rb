require "rubygems"
require "nokogiri"
require "open-uri"

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }


links = findRecipeLinks(57) #start from page 57
parseRecipes(links)
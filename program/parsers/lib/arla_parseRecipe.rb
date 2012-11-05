def parseRecipes(links)
	puts "Starting to parse " + links.length.to_s + " links"
	for i in 0...links.length
		puts "Parsing: " + links[i].to_s
		parseRecipe(links[i])
	end
end

def parseRecipe(recipeUrl)
	puts "Parsing ingredients from link: " + recipeUrl
	doc = Nokogiri::HTML open(recipeUrl)
	findIngredients(doc)
end 



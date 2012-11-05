require "nokogiri"
require "open-uri"

def findIngredients(doc)
	ing = doc.xpath("//ul[@class='ingredientList']//li")
	ingredients = []
	ing.each do |node|
		stripped = node.text.strip
		if stripped.length > 0
			ingredients << node.text.strip   #Remove leading and trailing white spaces 
		end
	end
	puts "Found ingredients: "
	puts ingredients
end

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

def findRecipeLinks(startingPage)
	puts "Finding recipe links from page " + startingPage.to_s + " and forward"
	recipesFound = true
	links = []
	page = startingPage
	while recipesFound 
		puts "Searching for links on page " + page.to_s
		link = "http://www.arla.dk/Services/SearchService.asmx/RecipeResult?q=allRecipe&paging="+page.to_s()+"&include=&exclude=&area=recipeSearch&languageBranch=da"
		xml = Nokogiri::XML open(link)
		doc = Nokogiri::HTML xml.at('string').text
		urlsOnPage = doc.xpath("//h2//a").map{|link| "http://www.arla.dk"+link["href"]}
		page += 1
		if urlsOnPage.length == 0
			puts "No links found"
			puts "Found a total of " + links.length.to_s + " recipe links"
			return links
		else
			puts "Found " + urlsOnPage.length.to_s + " links"
			links += urlsOnPage
		end
	end
end



links = findRecipeLinks(57) #start from page 57
parseRecipes(links)







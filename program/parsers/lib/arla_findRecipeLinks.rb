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
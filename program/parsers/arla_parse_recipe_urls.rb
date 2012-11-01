require "nokogiri"
require "open-uri"
page = 1
recipesFound = true
while recipesFound 
	link = "http://www.arla.dk/Services/SearchService.asmx/RecipeResult?q=allRecipe&paging="+page.to_s()+"&include=&exclude=&area=recipeSearch&languageBranch=da"
	xml = Nokogiri::XML open(link)
	doc = Nokogiri::HTML xml.at('string').text
	urlsOnPage = doc.xpath("//h2//a").map{|link| "http://www.arla.dk"+link["href"]}
	page += 1
	if urlsOnPage.length == 0
		recipesFound = false
	end
	for i in 0..urlsOnPage.length
		puts "Found link: "+urlsOnPage[i].to_s()
	end
end


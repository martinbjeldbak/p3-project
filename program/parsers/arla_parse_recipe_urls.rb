require "nokogiri"
require "open-uri"
page = 1
urls = Array.new(0)
recipesFound = true
while recipesFound 
	link = "http://www.arla.dk/Services/SearchService.asmx/RecipeResult?q=allRecipe&paging="+page.to_s()+"&include=&exclude=&area=recipeSearch&languageBranch=da"
	xml = Nokogiri::XML open(link)
	doc = Nokogiri::HTML xml.at('string').text
	newUrls = doc.xpath("//h2//a").map{|link| "http://www.arla.dk"+link["href"]}
	urls = urls + newUrls
	page += 1
	if newUrls.length == 0
		recipesFound = false
	end
	puts "Parsed: "+page.to_s()+" " 
end

File.open("C:/arla_urls.txt", 'w') {|f| f.puts(urls) }
puts urls
gets
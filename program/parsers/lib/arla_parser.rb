class ArlaParser

	@@url = ""
	@@page = ""

	def self.SetUrl(url) #Opens an url using Nokogiri and storse the Nokogiri::document in @@page, allowing other methods to access the document
		@@url = url
		@@page = Nokogiri::HTML(open(url))
	end

	def self.GetPortion() #Method that retrieves a recipe's default portion size from www.arla.dk
	  portion = @@page.css("div.listAmount").text.to_s.strip.partition(" ")
	  return portion[0]
	end

	def self.GetName() #Method that retrieves a recipes name from the <title> tag
	  name = @@page.css("title").text.to_s.strip.partition(" |")
	  return name[0]
	end

	def self.GetPrepTime()
		prepTime = @@page.css("p.nutrition time").text.to_s.strip.partition(" ")
		if (prepTime[0] == "60+")
			prepTime[0] = "61"
		end
		return prepTime[0]
	end

	def self.GetImage() #method that retrieves and saves an recipe's image from www.arla.dk
		span_id = "ctl00_ctl00_ctl00_cphContent_cphMainContent_cphArticleArea_uiRecipe_uiConImg"
		img_url = @@page.css("span##{span_id} img")[0]["src"].to_s
		data = File.open(open(img_url), "rb").read
		return data
	end

	def self.GetIngredients #Returns an array of ingredients found in Nokogiri document @@page
		doc = @@page
		ing = doc.xpath("//ul[@class='ingredientList']//li")
		ingredients = []
		ing.each do |node|
			if node.xpath(".//strong").text.length == 0 #If not containing a strong element for headings like 'Acessories'
				stripped = node.text.strip
				if stripped.length > 0
					ingredients << node.text.strip   #Remove leading and trailing white spaces 
				end
			end
		end
		return ingredients
	end

	def self.FindLinks(startingPage) #Finds recipe links from all index pages on Arla from startingPage and up
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
		return links
	end
end #end of class
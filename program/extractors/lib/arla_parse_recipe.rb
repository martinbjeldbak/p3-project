def parseRecipes(links) #Parses a single recipe
	puts "Starting to parse " + links.length.to_s + " links"
	for i in 0...links.length
		puts "Parsing: " + links[i].to_s
		parseRecipe(links[i])
	end
end

def insertRecipeInDB(name, url, preptime, picture) #Inserts recipe data into the database
	DB.Get.query("INSERT INTO `recipes` (`id`, `name`, `url`, `picture`, `rating`, `created_at`, `updated_at`, `prep_time`) 
	VALUES (NULL,
	'"+name+"',
	'"+url+"',
	'"+db.escape_string(picture).force_encoding("UTF-8")+"',
	NULL, 
	NOW(), 
	NOW(), 
	'"+preptime+"'
	)")
	return db.insert_id #returns last inserted id
end

def parseRecipe(recipe_url) #Gets all the needed information about a recipe
	puts "Parsing ingredients from link: " + recipe_url
	ArlaParser.SetUrl(recipe_url)
	preptime = ArlaParser.GetPrepTime()
	img = ArlaParser.GetImage()
	name = ArlaParser.GetName()
	puts "Parsing recipe name: "+ name.to_s
	recipe_id = insertRecipeInDB(name, recipe_url, preptime, img)	
	portion = ArlaParser.GetPortion()
	ingredients = ArlaParser.GetIngredients()   #Get ingredients from the recipe url
	puts "Ingredients loaded: "
	IngredientInserter.Insert(recipe_id, ingredients, portion) #handles the insertion of ingredients
	puts "Ingredients inserted"
end 

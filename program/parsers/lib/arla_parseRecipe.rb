


def parseRecipes(links)
	db = Mysql.init
	db.options(Mysql::SET_CHARSET_NAME, 'utf8')
	db.real_connect('198.175.125.69', 'foodl', 'foodl4321', 'foodl', 3306, '/usr/local/lib/mysql.sock')
	db.query("SET NAMES utf8")
	
	puts "Starting to parse " + links.length.to_s + " links"
	for i in 0...links.length
		puts "Parsing: " + links[i].to_s
		parseRecipe(links[i], db)
	end
end

def insertRecipeInDB(db, name, url, preptime, picture)
	db.query("INSERT INTO `recipes` (`id`, `name`, `url`, `picture`, `rating`, `created_at`, `updated_at`, `prep_time`) 
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

def parseRecipe(recipe_url, db)
	puts "Parsing ingredients from link: " + recipe_url
	#doc = Nokogiri::HTML open(recipeUrl)
	
	ArlaParser.SetUrl(recipe_url)
	
	preptime = ArlaParser.GetPrepTime()
	img = ArlaParser.GetImage()
	name = ArlaParser.GetName()
	
	puts "Parsing recipe name: "+ name.to_s
	
	recipe_id = insertRecipeInDB(db, name, recipe_url, preptime, img)
	
	portion = ArlaParser.GetPortion()
	ingredients = ArlaParser.GetIngredients()
	IngredientInserter.Insert(recipe_id, ingredients, portion) #handles the insertion of ingredients
	
	
end 

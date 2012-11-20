class IngredientComponent

@@amount = ""
@@unit = ""
@@original = ""
@@food_name = ""

@@unitTable = ["stykke", "stykker", "dåse", "tsk","et nip","spsk","stilk","dl","l","liter","g","gram","mg","miligram","lille", "en rest",
					"kg","kilo","kilogram", "skiver", "skive", "fad", "glas", "krus", "bakke", "net", "kurv"]
	

def self.is_number(s)
   return true if Float(s) rescue false
end

def self.remove_weight_suggestion()
	for i in 0..@@food_name.length-6
		if (@@food_name[i,6] == " (ca. ")
			@@food_name = @@food_name[0..i-1]
			return
		end
	end
end

def self.remove_fx_suggestion()
	for i in 0..@@food_name.length-5
		if (@@food_name[i,5] == ", fx ")
			@@food_name = @@food_name[0..i-1]
			return
		end
	end
	return
end

def self.remove_non_food_substrings()
	
	removes = 	[	"skrællede","i","både","stykker","skiver","tern","med","meget","finthakket","finthakkede","grofthakkede","groft","tynde",
					"strimler","kogt","skyllet","klippet","frisk","ristet","fast","modnet","vaskede","pillede","små","store","luftede","faste", "kolde","varme", "revet",
					"mindre", "Arla Karolines Køkken®", "Arla", "lange", "stave", "stødt", "dampede", "grøn", "tørret", "soltørrede", "friskkværnet", "friskpresset",
					"koldt", "friskrevet", "grofthakket", "stilke","ristede","hakkede","friske","mild","sød","kogte","dampet","fintsnittet","buketter","vildtfond", "evt.",
					"uden skind", "moden", "presset", "fed", "saltede", "til pensling", "syrnet", "sigtet", "mellemlagret", "sprødstegt", "fintrevet", "eller",
					"stegt", "kold", "fra dåse", "løse", "lyse", "uden kerner", "milde", "røde", "stort", "snittet", "fintstrimlet", "blødt", "røget", "lunt",
					"hvid", "saltlage", "knækkede", "halve", "grønne", "bør omrystes"]
	removes.each do |s|

	#Removes at start of string			"tynde bananer" -> "tynde bananer" and "bananer, tynde" -> "bananer" 
		if (@@food_name[0,s.length+1] == s+" ")
			@@food_name = @@food_name[s.length+1..@@food_name.length]
		end
		if (@@food_name[0,s.length+2] == s+", ")
			@@food_name = @@food_name[s.length+2..@@food_name.length]
		end
		
		#Removes at end of string		"ærter, pillede" -> "ærter" and "kartofler i både" -> "kartofler" 
		if (@@food_name[@@food_name.length-s.length-1,s.length+1] == " "+s)
			@@food_name = @@food_name[0..@@food_name.length-s.length-2]
		end
		if (@@food_name[@@food_name.length-s.length-2,s.length+2] == ", "+s)
			@@food_name = @@food_name[0..@@food_name.length-s.length-3]
		end
	
	#Removes in string					"bananer, pillede ..." -> "bananer ..." "bananer i skiver ..." -> "bananer ..."
		for i in 0..@@food_name.length do
			if (@@food_name[i,s.length+2] == " "+s+" ")
				@@food_name = @@food_name[0..i]+@@food_name[i+s.length+2..@@food_name.length]
			end
			if (@@food_name[i,s.length+3] == " "+s+", ")
				@@food_name = @@food_name[0..i]+@@food_name[i+s.length+3..@@food_name.length]
			end
		end
		
	end
end

def self.modify_white_spaces(str) #Converts the weird whitespaces to real white spaces
	for i in 0..str.length-1
		if (is_space(str[i]))
			str[i] = " "
		end
	end
	return str
end

def self.is_space(char)
	return char == " " || char.bytes.to_a == [194, 160] #when parsing, some whitespaces are encoded weird
end

def self.trim_food_name()
	remove_weight_suggestion() #Removes the "(ca. 350 g)" postfix fr
	remove_fx_suggestion() #Removes the "fx belle de boskoop..." postfix
	#remove_non_food_substrings() #Removes words like "skrællede, vaskede, skyllede, pillede"	
end

def self.Analyze(ingredient, portion_size)
	@@original = ingredient
	@@amount = ""
	ingredient = modify_white_spaces(ingredient)

	#EXTRACT AMOUNT
	run = true
	while ingredient.length > 0 && run do
		if (is_number(ingredient[0]))
			@@amount += ingredient[0]
			ingredient.slice!(0)
		elsif (ingredient[0] == "½")
			@@amount += ".5"
			ingredient.slice!(0)
		elsif (ingredient[0] == "¼")
			@@amount += ".25"
			ingredient.slice!(0)
		elsif (ingredient[0] == "¾")
			@@amount += ".75"
			ingredient.slice!(0)
		else
			run = false
		end
	end
	

	@@amount = @@amount.to_f / portion_size.to_f

	# REMOVE SPACE AFTER AMOUNT
	if (ingredient[0] == " ") #remove leading whitespace
		ingredient[0] = ''
	end
	#EXTRACT UNIT
	@@unitTable.each do |s|
		if ingredient[0..s.length] == s + " "  #important to check space after, ex: "2 g fløde" or "2 glas kartofler"  
			@@unit = s
			ingredient[0..s.length] = ''
			break
		end
	end
	@@food_name = ingredient
	trim_food_name() #removes different texts from the food_name, that will confuse the mapping to a food type in DB
end



def self.GetAmount
	return @@amount
end

def self.GetUnit
	return @@unit
end

def self.GetFoodName
	return @@food_name
end

def self.GetOriginal
	return @@original
end

end #end of class
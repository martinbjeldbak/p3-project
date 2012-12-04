#Provides methods for analyzing an ingredients components: amount, unit, name
#Usage:
#Call Analyze("5 kg kartofler")
#GetAmount() -> 5
#GetUnit() -> kg
#GetName() -> kartofler
#GetOriginal -> 5 kg kartofler

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
		@@original = ingredient.dup #dont hold the reference since ingredient will change in this scope
		@@amount = ""
		@@unit = ""
		ingredient = modify_white_spaces(ingredient)

		#EXTRACT AMOUNT (in Arla's syntax, amount is always first)
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

		# REMOVE SPACE AFTER AMOUNT (Arla's syntax has always space after amount)
		if (ingredient[0] == " ")
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
	
	def self.GetName
		return @@food_name
	end
	
	def self.GetOriginalName
		return @@original
	end
end #end of class
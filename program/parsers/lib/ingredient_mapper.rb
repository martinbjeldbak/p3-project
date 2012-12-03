#Provides the method Map(str), that find the ebst matching foodl.food_type in DB, and returns it as [food_type_id, match_percent, name]

class IngredientMapper

require "levenshtein" #a module that provides the levenshtein function for finding difference between 2 strings

	def self.Map(str) #returns [id, match_percent, name] of the best matching food type	
		best_match = -1
		best_id = 0
		best_name = "error"
		food_types = FoodTypes.Get()
		food_types.each do |s|
			name = s[0]
			id = s[1]
			match = TextComparer.Compare(str, name)
			if (match > best_match)
				best_match = match
				best_id = id
				best_name = name
			end
		end
		return [best_id, best_match, best_name]
	end
	
	def self.TestMap(str) #returns [id, match_percent, name] of the best matching food type	
		best_match = [-1, -1, -10000, -10000, -10000]
		best_id = 0
		best_names = []
		food_types = FoodTypes.Get()
		
		food_types.each do |s|
			name = s[0].downcase
			match = []
			match << TextComparer.Compare(str, name)
			match << TextComparer.Compare2(str, name)
			match << TextComparer.Compare3(str, name)
			match << TextComparer.Compare4(str, name)
			match << TextComparer.Compare5(str, name)
			for i in 0...best_match.length do
				if (match[i] > best_match[i])
					best_match[i] = match[i]
					best_names[i] = name
				end
			end
		end
		for i in 0...best_match.length do
			puts best_names[i] + "          : " + best_match[i].to_s
		end
	end
	
	def self.Test() #Test different mapping methods to see how the results are different
		input = "agurk"
		while input != "" do
			TestMap(input)
			input = gets.chomp
		end
	end
end
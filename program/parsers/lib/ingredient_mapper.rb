#Provides the method Map(str), that find the ebst matching foodl.food_type in DB, and returns it as [food_type_id, match_percent, name]

class IngredientMapper

@@warn_below = 1	#puts a warning in the console if an ingredient is mapped with a match below this. Match is in range (0-100)

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
		if (best_match < @@warn_below)
			puts "Warning: low match ("+best_match.to_s+") between: '"+str+"' and '"+ best_name +"'"
		end
		return [best_id, best_match, best_name]
	end
end
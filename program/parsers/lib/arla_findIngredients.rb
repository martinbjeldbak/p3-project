def findIngredients(doc)
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
	puts "Found ingredients: "
	puts ingredients
end
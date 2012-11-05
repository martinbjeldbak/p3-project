
#method that retrieves a recipe's preparation time from www.arla.dk
def prepTime(page_url)
  page = Nokogiri::HTML(open(page_url))
  prepTime = page.css("p.nutrition time").text.to_s.strip.partition(" ")
  return prepTime[0]
end

#method that retrieves a recipe's default portion from www.arla.dk
def portion(page_url)
  page = Nokogiri::HTML(open(page_url))
  portion = page.css("div.listAmount").text.to_s.strip.partition(" ")
  return portion[0]
end
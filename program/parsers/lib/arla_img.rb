
#method that retrieves and saves an recipe's image from www.arla.dk
def img_snapper(page_url, span_id = "ctl00_ctl00_ctl00_cphContent_cphMainContent_cphArticleArea_uiRecipe_uiConImg")
  page = Nokogiri::HTML(open(page_url))
  img_url = page.css("span##{span_id} img")[0]["src"].to_s
  File.open(File.basename(img_url),'wb'){|f| f.write(open(img_url).read)}  
end
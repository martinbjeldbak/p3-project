require 'rubygems'
require 'nokogiri'
require 'open-uri'

PAGE_URL = "http://www.foodcomp.dk/v7/fvdb_alphlist.asp?FL=All"
page = Nokogiri::HTML(open(PAGE_URL))
file = File.new("ingredienser.txt", "w")

page.css('table#table5 tr').select do |row|
  if row.values.include?("L1") or row.values.include?("L2")
    file.puts row.css('td')[1].text
  end
end

file.close

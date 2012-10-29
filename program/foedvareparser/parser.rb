require 'rubygems'
require 'nokogiri'
require 'open-uri'

PAGE_URL = "http://www.foodcomp.dk/v7/fvdb_alphlist.asp?FL=All"
page = Nokogiri::HTML(open(PAGE_URL))
file = File.new("ingredienser.txt", "w")

foodTableRows = page.css('table#table5').css('tr').css('td').select do |row|
  row['height'] != "20" and row['width'] != '6%' and row['width'] != '94%'
end

foodTableRows2 = page.css('table#table5 tr').select do |row|
  if (row.values.include?("L1") or row.values.include?("L2"))
    file.puts row.text
  end
end


#foodTableRows.each { |row| file.puts row.text }

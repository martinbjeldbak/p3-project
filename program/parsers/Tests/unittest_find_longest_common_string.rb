require "rubygems"
require_relative '../lib/text_comparer'

test_cases = 
		[
		["aa12345", "aa67890", "aa"],
		["aa12345", "678aa90", "aa"],
		["aa12345", "67890aa", "aa"],
		["123aa45", "678aa90", "aa"],
		["123aa45", "67890aa", "aa"],
		["12345aa", "67890aa", "aa"],
		["12345aa", "aa", "aa"],
		["aa", "12345aa", "aa"],
		["12233344455555", "555554444333221", "55555"],
		["12233355555444", "555553334444221", "55555"],
		["55555122333444", "555554444333221", "55555"],
		["122333444455555", "444433355555221", "55555"],
		["122333555554444", "444455555333221", "55555"],
		["555551223334444", "444455555333221", "55555"],
		["122333444455555", "555554444333221", "55555"],
		["122555553334444", "555554444333221", "55555"],
		["555551223334444", "555554444333221", "55555"],
		["a1c", "a2c", "a"],
		["a1c", "c2a", "a"],
		["c1a", "a2b", "a"],
		["aaabbbccc", "aaabbbccc", "aaabbbccc"],
		["aaabbbccc", "cccbbbaaa", "aaa"],
		["cccbbbaaa", "aaabbbccc", "ccc"],
		["122333", "", ""],
		["", "122333", ""],
		["", "", ""],
		]
	
errors = false	
test_cases.each do |array|
	result = TextComparer.find_longest_common_substring(array[0], array[1])
	if (result != array[2])
		errors = true
		puts "Compare('" + array[0] + "' , '" + array[1] + "') is '" + result + "', expected: '" + array[2] + "'"
	end
end
if (errors)
		puts "Errors found"
	else
		puts "No errors found"
	end
	
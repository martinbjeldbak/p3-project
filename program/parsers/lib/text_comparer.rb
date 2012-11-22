#Provides method Compare(str1, str2) for calculating how equal two strings are (0-100 %)

class TextComparer

def self.find_longest_common_string(str1, str2)
	lc = ""
	for start in 0...str1.length - lc.length do
		for length in lc.length + 1..str1.length - start do
		  find = str1[start,length]
		  if (str2.include? find)
			lc = find
		  end
		end
	end
	return lc;
end
  
def self.remove_first_on_text(text, remove)
	for i in 0..text.length - remove.length do
		if (text[i, remove.length] == remove) 
		  return text[0,i] + text[i+remove.length,text.length-(i+remove.length)]
		end
	end
	return text
end

def self.Compare(txt1, txt2)
	txt1 = txt1.downcase
	txt2 = txt2.downcase
	max_size = [txt1.length, txt2.length].max
	total_size = txt1.length + txt2.length
	if (max_size == 0) #if both string are empty
		return 100
	end
	score = 0
	runs_left = 2
	while (lc = find_longest_common_string(txt1, txt2)) != "" && runs_left > 0 do
		runs_left -= 1
		txt1 = remove_first_on_text(txt1, lc)
		txt2 = remove_first_on_text(txt2, lc)
		score += lc.length * lc.length
	end
	leftovers = txt1.length + txt2.length
	score /= (1 + leftovers).to_f
	max_score = max_size * max_size
	match = score.to_f * 100 / max_score
	return match
end

def self.test() #Used to do test in console to check match between different inputted strings
	input1 = "agurk"
	input2 = "gakurk"
	while input1 != "" || input2 != "" do
		puts "Indtast ingrediens 1: "
		input1 = gets.chomp
		puts "Indtast ingrediens 2: "
		input2 = gets.chomp
		puts Compare(input1, input2).to_f
	end
end

end #end of class




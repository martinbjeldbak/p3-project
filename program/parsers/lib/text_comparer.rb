#Provides methods for calculating how equal two strings are (0-100 %)

class TextComparer

@@powerScore = true #the point system for string match algorithm (longer matching strings will get good rewards)


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

def self.find_text_match(txt1, txt2)
	txt1 = txt1.downcase
	txt2 = txt2.downcase
	maxStartSize = [txt1.length, txt2.length].max
	if (maxStartSize == 0) #if both string are empty
		return 1
	end
	score = 1
	while (lc = find_longest_common_string(txt1, txt2)) != "" do
		txt1 = remove_first_on_text(txt1, lc)
		txt2 = remove_first_on_text(txt2, lc)
		if (@@powerScore)
			score += lc.length * lc.length 
		else
			score += lc.length
		end
		score -= 1
	end
	if (@@powerScore)
		match = score * 100 / (maxStartSize * maxStartSize)
	else
		match = score * 100 / maxStartSize
	end
	return match
end

def self.test()
	input1 = "agurk"
	input2 = "gakurk"
	while input1 != "" || input2 != "" do
		puts "Indtast ingrediens 1: "
		input1 = gets.chomp
		puts "Indtast ingrediens 2: "
		input2 = gets.chomp
		puts find_text_match(input1, input2)
	end
end



end #end of class




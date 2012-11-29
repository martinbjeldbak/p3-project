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

def self.Compare(txt1, txt2) #Our own compare method (exponentiel)
txt1 = txt1.force_encoding("ASCII")
txt2 = txt2.force_encoding("ASCII")
	txt1 = txt1.downcase
	txt2 = txt2.downcase

	txt1 = txt1.to_s
	txt2 = txt2.to_s
	max_size = [txt1.length, txt2.length].max
	total_size = txt1.length + txt2.length
	if (max_size == 0) #if both string are empty
		return 100
	end
	score = 0
	while (lc = find_longest_common_string(txt1, txt2)) != "" do
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

def self.Compare2(txt1, txt2) #our own compare method (linear)
txt1 = txt1.force_encoding("ASCII")
txt2 = txt2.force_encoding("ASCII")
	txt1 = txt1.downcase
	txt2 = txt2.downcase

	txt1 = txt1.to_s
	txt2 = txt2.to_s
	max_size = [txt1.length, txt2.length].max
	total_size = txt1.length + txt2.length
	if (max_size == 0) #if both string are empty
		return 100
	end
	score = 0
	while (lc = find_longest_common_string(txt1, txt2)) != "" do
		txt1 = remove_first_on_text(txt1, lc)
		txt2 = remove_first_on_text(txt2, lc)
		score += lc.length
		score -= 1
	end
	leftovers = txt1.length + txt2.length
	score /= (1 + leftovers).to_f
	max_score = max_size
	match = score.to_f * 100 / max_score
	return match
end

def self.Compare3(str1, str2) #levenshtein Text::Levenshtein with substitution cost = 2
  str1 = str1.force_encoding("UTF-8")
  str2 = str2.force_encoding("UTF-8")
  str1 = str1.downcase
  str2 = str2.downcase
  prepare =
    if "ruby".respond_to?(:encoding)
      lambda { |str| str.encode(Encoding::UTF_8).unpack("U*") }
    else
      rule = $KCODE.match(/^U/i) ? "U*" : "C*"
      lambda { |str| str.unpack(rule) }
    end

  s, t = [str1, str2].map(&prepare)
  n = s.length
  m = t.length
  return m if n.zero?
  return n if m.zero?

  d = (0..m).to_a
  x = nil

  n.times do |i|
    e = i + 1
    m.times do |j|
      cost = (s[i] == t[j]) ? 0 : 2
      x = [
        d[j+1] + 1, # insertion
        e + 1,      # deletion
        d[j] + cost # substitution
      ].min
      d[j] = e
      e = x
    end
    d[m] = x
  end

  return x
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




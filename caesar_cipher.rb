#simple caesar cipher program that take a string and encodes it. 


puts "Welcome to Cipher"
puts "Please input the phrase you wish to encode: "
phrase = gets.chomp
puts "and now a number for the key: "
key = gets.chomp.to_i

def cipher(phrase, key)
	output = ""
	phrsArr = phrase.split("")
	phrsArr.each do |chr|
		new_position = chr.ord + key
		diff = 0
		if (chr.ord) > 64 && (chr.ord) < 91 && new_position > 90
			diff = new_position - 90
			new_position = 65 + diff
		elsif (chr.ord) > 97 && (chr.ord) < 123 && new_position > 122
			diff = new_position - 122
			new_position = 96 + diff
		elsif (chr.ord) > 31 && (chr.ord) < 48
			new_position = chr.ord
		end

		output += new_position.chr
	end

	return output
end



puts cipher(phrase, key)
			
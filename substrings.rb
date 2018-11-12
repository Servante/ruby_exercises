#substrings

#takes a word as first argument, and an array of valid substrings(your dictionary) as the second argument. 

#Returns a hash listing each substring (case insensitive) that was found in the original string and how many times it was found. 

def substrings(string, dictionary)
	matched_words = Hash.new  #creates new hash
 	string.downcase!  #converts strings to down case
	dictionary.each do |input| 
		matched = string.scan(input) #adds a temporary variable with the matched word
		unless matched == []   #if the variable is empty from above step, skips to the next iteration
			matched_words[input] = matched.length  #adds the word to the hash as a value, and adds a one to the key for word
		end
	end
	matched_words #displays hash
end
	

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
puts substrings("Howdy partner, sit down! How's it going?", dictionary)
# Stock Picker - takes an array of numbers and gives you the best day to buy and best day to sell.



def lowest(l)
		b = l.dup
		b.pop
		b.min
	end

def highest(h,lindex)
		b = h.dup
		b.slice!(0..lindex)
		high = (b.max)
	end



def stock_picker(x)
	low = lowest(x)
	lindex = (x.index(low)) 
	high = highest(x, lindex)
	hindex = (x.index(high))

	#adding to variables to offset zero index of results. For readability. 
	puts "The best day to buy is on day #{(lindex + 1)} for $#{low} and sell on day #{(hindex + 1)} for $#{high}."
end


stocks = [71, 21, 62, 2, 64, 63, 25, 15, 17, 53, 4]
stock_picker(stocks)
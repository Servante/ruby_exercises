def bubble_sort array
	swapped = true
	while swapped == true
		swapped = false
		(array.length - 1).times do |x| 	 	
			if array[x] > array [x+1]
				array[x], array[x+1] = array[x+1], array[x]		
				swapped = true
				break if swapped == false
			end
		end
		p array
	end
end

array = [90, 66, 49, 82, 58, 34, 26, 23, 75, 32]

bubble_sort(array)




def bubble_sort_by array
	swapped  = true
	while swapped == true
 		swapped = false
 		(array.length - 1).times do |x|
		if yield(array[x], array[x+1]) > 0
			array[x], array[x+1] = array[x+1], array[x]
 			swapped = true
 			break if swapped == false
 			end
 		end
 	end
 	p array
 end

			
bubble_sort_by(["hi", "hello", "hey"]) do |left,right|
 	left.length - right.length
 end




=begin
	
Build a method #merge_sort that takes in an array and returns a sorted array, 
using a recursive merge sort methodology.


Tips:Think about what the base case is and what behavior is happening again
and again and can actually be delegated to someone else (e.g. that same method!).


=end


def merge_sort(arr)
	n = arr.size
	a = []
	if n < 2
		arr		
	else
		b = merge_sort(arr[0, n/2])
		c = merge_sort(arr[n/2, n])

		until b.empty? || c.empty?
			a <<  if b[0] < c[0]
							b.shift
						else
							c.shift
						end
		end
		a.concat(b, c)
	end
end

arr = Array.new(23) {rand (1..1000)}

p merge_sort(arr)










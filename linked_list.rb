=begin


You will need two classes:

LinkedList class, which will represent the full list.

Node class, containing a #value method and a link to the #next_node, set both as nil by default.

-value method simply returns value



Build the following methods in your linked list class:

1. append(value) adds a new node containing value to the end of the list

2. prepend(value) adds a new node containing value to the start of the list

3. size returns the total number of nodes in the list

4. head returns the first node in the list

5. tail returns the last node in the list

6. at(index) returns the node at the given index

7. pop removes the last element from the list

8. contains?(value) returns true if the passed in value is in the list and otherwise returns false.

9. find(value) returns the index of the node containing value, or nil if not found.

10. to_s represent your LinkedList objects as strings, so you can print them out and preview them in the console. The format should be: ( value ) -> ( value ) -> ( value ) -> nil


Extra Credit

01. insert_at(value, index) that inserts the node with the provided value at the given index

02. remove_at(index) that removes the node at the given index. (You will need to update the links of your nodes in the list when you remove a node.)

=end

require "pry"

def reload
	load 'linked_lists.rb'
end



class LinkedList
	attr_accessor :head, :tail
	include Enumerable


	def initialize
		@head = nil
		@tail = nil
	end

	def each
		return nil if @head.nil?
		entry = @head
		until entry.nil?
			yield entry
			entry = entry.next
		end
	end

	def append(v)
		if @head.nil?
			@head = v
			@tail = v
		else
			@tail.next = v
			@tail = v
		end
	end

	def prepend(v)
		if @head.nil?
			@head = v
			@tail = v
		else
			v.next = @head
			@head = v
		end
	end

	def size 
		#size returns the total number of nodes in the list
		counter = 0
		self.each {counter += 1}
		return counter
	end

	def head
		#returns the first node in the list
		return @head
	end

	def tail
		#returns the last node in the list
		return @tail
	end

	def at(index)
		counter = -1
		#returns the node at the given index
		until counter == index
			self.each do |x|
			binding.pry
			
			when counter == index
				binding.pry
				return x
		end
	end

	end

	def pop
		#removes the last element from the list
	end

	def contains?(value) 
		#returns true if the passed in value is in the list and otherwise returns false.
	end

	def find(value)
		#returns the index of the node containing value, or nil if not found.
	end
end

Node = Struct.new(:data, :next)






	



=begin


Build the following methods in your linked list class:

1. #append(value) adds a new node containing value to the end of the list - x

2. #prepend(value) adds a new node containing value to the start of the list - x

3. #size returns the total number of nodes in the list

4. #head returns the first node in the list

5. #tail returns the last node in the list

6. #at(index) returns the node at the given index

7. #pop removes the last element from the list

8. #contains?(value) returns true if the passed in value is in the list and otherwise returns false.

9. #find(value) returns the index of the node containing value, or nil if not found.

10. #to_s represent your LinkedList objects as strings, so you can print them out and preview them in the console. The format should be: ( value ) -> ( value ) -> ( value ) -> nil

EC

11. #insert_at(value, index) that inserts a new node with the provided value at the given index.

12. #remove_at(index) that removes the node at the given index.ls


=end


require_relative "node.rb"
require 'pry'

def reload  #irb helper
	load 'linked_list.rb'
end


class LinkedList
	attr_accessor :head, :tail

	def initalize
		@head = nil
		@tail = nil
	end

	def each
		return nil if @head.nil?
		entry = @head
		until entry.nil?
			yield entry
			entry = entry.next_node
		end
	end

	def empty_list(value) #assigns value to head/tail if list is empty
		@head = value ; @tail = value		
	end

	def append(value)
		if @head.nil?
			empty_list(value)
		else
			@tail.next_node = value ; @tail = value
		end
	end

	def prepend(value)
		if @head.nil?
			empty_list(value)
		else
			value.next_node = @head ; @head = value
		end
	end

	def size
		return nil if @head.nil?
		counter = 0
		self.each {counter += 1}
		return counter		
	end	

	def head
		@head
	end

	def tail
		@tail
	end
end



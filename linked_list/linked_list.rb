=begin


Build the following methods in your linked list class:

1. #append(value) adds a new node containing value to the end of the list - x

2. #prepend(value) adds a new node containing value to the start of the list - x

3. #size returns the total number of nodes in the list - x

4. #head returns the first node in the list - x

5. #tail returns the last node in the list - x

6. #at(index) returns the node at the given index - x

7. #pop removes the last element from the list - x

8. #contains?(value) returns true if the passed in value is in the list and otherwise returns false. - x

9. #find(value) returns the index of the node containing value, or nil if not found. - x

10. #to_s represent your LinkedList objects as strings, so you can print them out and preview them in the console. The format should be: ( value ) -> ( value ) -> ( value ) -> nil -- x

EC

11. #insert_at(value, index) that inserts a new node with the provided value at the given index. - x

12. #remove_at(index) that removes the node at the given index.



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

	def at(index)
		counter = 0
		self.each do |node|
			return node if counter == index
			counter += 1
		end
	end

	def pop
		if self.size.nil?
			puts "The list is empty."
		elsif @head == @tail
			@head = nil ; @tail = nil
		else
			@tail = self.at(self.size - 2) ; @tail.next_node = nil
		end
		return self
	end

	def contains?(value)
		arr = []
		self.each {|node| arr << node if node.value == value}
		arr.empty? ? false : true
	end

	def find(value)
		counter = -1
		self.each {|node|	counter += 1 ; return counter if node.value == value} 
	end

	def to_s
		array = []
		self.each {|node| array << "( #{node.value} ) ->" }
		array << " nil "
		return array.join(" ")
	end

	def insert_at(index, new_node)
		if self.at(index) == nil
			return nil
		elsif (self.at(index)) == (self.head)
			new_node.next_node = @head ; @head = new_node
	  else
	  	prior_node = self.at(index - 1)  
	  	replaced_node = self.at(index)
	  	prior_node.next_node = new_node ; new_node.next_node = replaced_node
	  end 	

		def remove_at(index)
	  	if self.at(index) == nil
	  		return nil
	  	elsif (self.at(index)) == (self.head)
	  		@head = self.at(index).next_node
	  	elsif (self.at(index)) == (self.tail)
	  		@tail = (self.at(index - 1)) ; self.at(index - 1).next_node = nil
	  	else
	  		self.at(index - 1).next_node = self.at(index).next_node
	  	end
	  end
	end
		



	private

	def each
		return nil if @head.nil?
		entry = @head
		until entry.nil?
			yield entry
			entry = entry.next_node
		end
	end

	def each_with_index
		return nil if @head.nil?
		entry = @head
		counter = 0
		until entry.nil?
			yield entry, counter
			counter += 1
			entry = entry.next_node
		end
	end
end



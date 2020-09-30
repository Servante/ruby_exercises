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

	def to_s
		output = []
		self.each {|n| output << "( #{n.data} ) -> " unless nil}
		output << "nil" ; output.join("")
	end

	def append(v)
		if @head.nil?
			@head = v ; @tail = v			
		else
			v.prev = @tail ; @tail.next = v ; @tail = v
		end
	end

	def prepend(v)
		binding.pry
		if @head.nil?
			@head = v ; @tail = v
		else
			v.prev = nil ; v.next = @head ; @head = v		
		end
	end

	def size 
		counter = 0
		self.each {counter += 1}
		return counter
	end

	def head
		return @head
	end

	def tail
		return @tail
	end

	def at(index)
		binding.pry
		self.each_with_index {|v, i| return v if i == index}
		puts "There are no records at that index."
	end

	def pop
		if @tail.nil?
			puts "I'm sorry, there is nothing to pop."
		else
			binding.pry
			@tail.prev.next = nil ; @tail = @tail.prev
		end
	end

	def contains?(value) 
		self.each {|v| return true if v.data == value}
		return false
	end

	def find(value)
		self.each_with_index {|v, i| return i if v.data == value}
	  puts "value not found."
	end

	def insert_at(value, index)
		counter = -1
		self.each do |n|
			counter += 1
			if counter == index
				new_node = Node.new(value, n.prev, n)
				n.prev.next = new_node
				n.prev = new_node
			end
		end
	end

	def remove_at(index)
		counter = -1
		self.each do |n|
			counter += 1
			if counter == index
				n.prev.next = n.next
				n.next.prev = n.prev
			end
		end
	end
end

Node = Struct.new(:data, :prev, :next)


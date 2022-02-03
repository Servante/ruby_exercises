class Node 
	attr_accessor :value, :next_node

	def initialize(value = nil, next_node = nil)
		@value = value
		@next_node = next_node
	end

	def update_next_node(update)
		node.next_node = update
	end
end


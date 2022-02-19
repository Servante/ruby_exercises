# frozen_string_literal: true


class Node  #move to node.rb
	attr_accessor :data, :left, :right
	include Comparable

	def initialize(data)
		@data = data
		@left = nil
		@right = nil
	end

	def <=>(other_data)
		data <=> other_data
	end
end
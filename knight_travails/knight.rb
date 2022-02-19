# frozen_string_literal: true


class Knight
	attr_accessor :location, :moves, :children

	def initialize(location)
		@location = location
		@moves = get_moves(location)
		@children = []
	end	

	def get_moves(location, result = [])
		base_moves = [[-2, -1], [-2, 1], [-1, 2], [1, 2], [2, 1], [2, -1], [-1, -2], [1, -2]]
		base_moves.each do |move|
			x = location[0] + move[0]
			y = location[1] + move[1]
			result << [x, y] if x.between?(0, 7) && y.between?(0, 7)
		end
		return result
	end
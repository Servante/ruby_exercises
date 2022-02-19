# frozen_string_literal: true


class Board

	def knight_travails(location, target)  
	 @alpha_knight = Knight.new(location)
	 create_tree(target)
	 path = find_path(target)
	 puts "You made it in #{(path.size) - 1} moves "
	 puts "Your path is:"
	 path.each_with_index {|move, index| puts "#{index}: #{move}"}
	end

	def create_tree(target, queue = [@alpha_knight], index = 0)
		current = queue[index]
		create_children(current)

		current.children.each do |child|
			next if queue.include?(child)

			queue << child
		end

		return if current = find_child(target)
		return if index >= 66

		index += 1
		create_tree(target, queue, index)
	end

	def create_children(knight)
		knight.moves.each do |move|
			child = find_child(move).nil? ? Knight.new(move) : find_child(move)
			knight.children << child
		end
	end

	def find_child(target, queue = [@alpha_knight], index = 0)
		found_knight = nil
		current = queue[index]		
		return if current.nil?

		current.children.each do |child|
			queue << child unless queue.include?(child)
			found_knight = child if child.location == target
		end
		
		index += 1
		return found_knight unless found_knight.nil?
		

		find_child(target, queue, index)
	end

	def find_path(target, path = [target])
		parent = find_parent(target)
		path << parent.location
		return path if parent == @alpha_knight

		find_path(parent.location, path)
	end

	def find_parent(target, queue = [@alpha_knight], index = 0)
		current = queue[index]
		parent = current.moves.any? { |move| move == target }
		return if current.nil?
		return current if parent == true

		current.children.each do |child|
			queue << child unless queue.include?(child)
		end

		index += 1
		find_parent(target, queue, index)
	end
end
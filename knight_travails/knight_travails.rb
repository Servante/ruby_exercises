
#user inputs a location and destination
#@alpha_knight is created accepting location and destination as parameters 
	#initializes new knight with location, moves, and empty results array
		#iterates through an array containing all possible moves
			#x,y locations are added with each move and if less than 7 are passed into a results array
			#return results into @moves
#binary search tree is created of knights(locations) with their possible moves as children
	#creates family(dest, queue = [@alpha], index = 0)
		#sets current variable with queue[index]
		#creates children(current)
			#iterates through current.moves
				#child = knight(move) if find_child(move) is nil else find_child(move)
					#find_child(dest, queue[@alph], index = 0)
					#set current variable 
					#set found_knight = nil
					#iterate through current.children
						#pass child to queue unless queue includes child
						#found_knight = child if child.location == destination
					#return found_knight if found_knight is not nil
					#index += 1
					#find_child(destination, queue, index)
				#new child is passed to current.children
		#iterates through current.children
			#passes child to queue unless queue.include child

		#returns if current == find_child(destination)
		#returns if index >= 66

		#index += 1
		#create_family(dest, queue = [@alpha], index)
#locate destination knight
	#find_path(destination, path = [destination])
		#parent = find_parent
				#find_parent(destination, queue = [@alpha], index = 0)
				#current = queue[index]
				#parent = current.children.any? (destination)
				#return if current nil
				#return current if parent == true
				#iterate through current children and pass each child to queue unless already in queue
				#increase index by one
				#recurse find_parent
	#path << parent.location
	#return path if parent == @alpha
	#find_path(parent.location, path)
#returns path
	#puts "you've reached your destination in #{}moves."
	#output the move and index

require 'pry'

def reload
	load 'knight_travails.rb'
end



#board



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
		#binding.pry
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
			# binding.pry
			found_knight = child if child.location == target
		end
		# binding.pry
		index += 1
		return found_knight unless found_knight.nil?
		

		find_child(target, queue, index)
	end

	def find_path(target, path = [target])
		# binding.pry
		parent = find_parent(target)
		# binding.pry
		path << parent.location
		return path if parent == @alpha_knight
		# binding.pry

		find_path(parent.location, path)
	end

	def find_parent(target, queue = [@alpha_knight], index = 0)
		# binding.pry
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

#knight   


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
end










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





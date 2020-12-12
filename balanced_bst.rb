=begin

1. Build a Node class. It is should have attributes for the data it stores as well as its left and right children. As a bonus, try including the Comparable module and make nodes compare using their data attribute.  - x

2. Build a Tree class which accepts an array when initialized. The Tree class should have a root attribute which uses the return value of #build_tree which you’ll write next. - x

3. Write a #build_tree method which takes an array of data (e.g. [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]) and turns it into a balanced binary tree full of Node objects appropriately placed (don’t forget to sort and remove duplicates!). The #build_tree method should return the level-1 root node. - x

4. Write an #insert and #delete method which accepts a value to insert/delete (you’ll have to deal with several cases for delete such as when a node has children or not). 

5. Write a #find method which accepts a value and returns the node with the given value.  - X

6. Write a #level_order method that returns an array of values. This method should traverse the tree in breadth-first level order. This method can be implemented using either iteration or recursion (try implementing both!). Tip: You will want to use an array acting as a queue to keep track of all the child nodes that you have yet to traverse and to add new ones to the list (as you saw in the video).

7. Write #inorder, #preorder, and #postorder methods that returns an array of values. Each method should traverse the tree in their respective depth-first order.

8. Write a #height method which accepts a node and returns its height. Height is defined as the number of edges in longest path from a given node to a leaf node.

9. Write a #depth method which accepts a node and returns its depth. Depth is defined as the number of edges in path from a given node to the tree’s root node.

10. Write a #balanced? method which checks if the tree is balanced. A balanced tree is one where the difference between heights of left subtree and right subtree of every node is not more than 1.

11. Write a #rebalance method which rebalances an unbalanced tree. Tip: You’ll want to create a level-order array of the tree before passing the array back into the #build_tree method.

12. Write a simple driver script that does the following:

1. Create a binary search tree from an array of random numbers (`Array.new(15) { rand(1..100) }`)
2. Confirm that the tree is balanced by calling `#balanced?`
3. Print out all elements in level, pre, post, and in order
4. try to unbalance the tree by adding several numbers > 100
5. Confirm that the tree is unbalanced by calling `#balanced?`
6. Balance the tree by calling `#rebalance`
7. Confirm that the tree is balanced by calling `#balanced?`
8. Print out all elements in level, pre, post, and in order


Tip: If you would like to visualize your binary search tree, here is a #pretty_print method that a student wrote and shared on Discord:

def pretty_print(node = @root, prefix = '', is_left = true)
  pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
  puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
  pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
end

=end

require "pry"

def reload
	load 'balanced_bst.rb'
end

def pretty_print(node = @root, prefix = '', is_left = true)
  pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
  puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
  pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
end


class Node 
	attr_accessor :data, :left_child, :right_child
	include Comparable

	def initialize(data)
		@data = data
		@left_child = nil
		@right_child = nil
	end

	def <=>(other_data)
		data <=> other_data
	end
end

class Tree
	attr_accessor :root, :arr

	def initialize (arr)
		@arr = arr.uniq.sort
		@root = build_tree(@arr)
	end

	def build_tree(arr, first = 0, last = (arr.length-1))		
		if first > last
			return nil
		else
			mid = (first + last)/2
			new_node = Node.new(arr[mid])
			new_node.left_child = build_tree(arr, first, (mid - 1))
			new_node.right_child = build_tree(arr, (mid + 1), last)  
			new_node
		end
	end

	def leaf?(n)
		if n.left_child == nil && n.right_child == nil
		true
		else
		false
		end 
	end

	def find(key, node = @root)
		if node == nil
			puts "no nodes found"
		else
			if key == node.data
				puts "node found"
				return node
			elsif key >= node.data
				find(key, node.right_child)
			elsif key <= node.data
				find(key, node.left_child)
			else
				puts "I do not understand."
			end
		end
	end

	def insert(key, root = @root)
		if root == nil
			return Node.new(key)
		elsif root.data == key
			puts "node already exists"
			return root
		end

		if root.data > key
			root.left_child = insert(key, root.left_child)
		else
			root.right_child = insert(key, root.right_child)
		end
		root
	end
end



array = Array.new(15) {rand (0..500)}
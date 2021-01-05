=begin

1. Build a Node class. It is should have attributes for the data it stores as well as its left and right children. As a bonus, try including the Comparable module and make nodes compare using their data attribute.  - x

2. Build a Tree class which accepts an array when initialized. The Tree class should have a root attribute which uses the return value of #build_tree which you’ll write next. - x

3. Write a #build_tree method which takes an array of data (e.g. [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]) and turns it into a balanced binary tree full of Node objects appropriately placed (don’t forget to sort and remove duplicates!). The #build_tree method should return the level-1 root node. - x

4. Write an #insert and #delete method which accepts a value to insert/delete (you’ll have to deal with several cases for delete such as when a node has children or not).  - X

5. Write a #find method which accepts a value and returns the node with the given value.  - X

6. Write a #level_order method that returns an array of values. This method should traverse the tree in breadth-first level order. This method can be implemented using either iteration or recursion (try implementing both!). Tip: You will want to use an array acting as a queue to keep track of all the child nodes that you have yet to traverse and to add new ones to the list (as you saw in the video). - X

7. Write #inorder, #preorder, and #postorder methods that returns an array of values. Each method should traverse the tree in their respective depth-first order. -X

8. Write a #height method which accepts a node and returns its height. Height is defined as the number of edges in longest path from a given node to a leaf node. - X

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


class Node 
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
			new_node.left = build_tree(arr, first, (mid - 1))
			new_node.right = build_tree(arr, (mid + 1), last)  
			new_node
		end
	end

	def pretty_print(node = @root, prefix = '', is_left = true)
		pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

	def leaf?(n)
		if n.left == nil && n.right == nil
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
			elsif key > node.data
				find(key, node.right)
			elsif key < node.data
				find(key, node.left)
			else
				puts "I do not understand."
			end
		end
	end

	def level_order(root = @root)
		if root == nil
			puts "Tree is empty"
		else
			q = [root]
			v = []
			while q.empty? == false
				current = q.shift
				q << current.left unless current.left == nil
				q << current.right unless current.right == nil
				v << current
			end
			return v
		end
	end

	def inorder(root = @root, array = [])  
		return array if root == nil

		inorder(root.left, array)
		array << root.data
		inorder(root.right, array)
	end

	def preorder(root = @root, array = [])
		return array if root == nil

		array << root.data
		preorder(root.left, array)
		preorder(root.right, array)
	end	

	def postorder(root = @root, array = [])
		return array if root == nil

		postorder(root.left, array)
		postorder(root.right, array)
		array << root.data		
	end	

	def insert(key, root = @root)
		if root == nil
			return Node.new(key)
		elsif root.data == key
			puts "node already exists"
			return root
		end

		if root.data > key
			root.left = insert(key, root.left)
		else
			root.right = insert(key, root.right)
		end
		root
	end

	def inorder_successor(root)
		current = root
		while current.left != nil
			current = current.left
		end
		current
	end

	def delete(key, root = @root)
		return root if root == nil

		if key < root.data
			root.left = delete(key, root.left)
		elsif key > root.data
			root.right = delete(key, root.right)
		else			
			if root.left == nil
				temp = root.right
				root = nil
				return temp			
			elsif root.right == nil
				temp = root.left
				root = nil
				return temp
			else
				temp = inorder_successor(root.right)
			  root.data = temp.data
			  root.right = delete(temp.data, root.right)
			end			
		end
		return root
	end

	def height(node = root)
		return -1 if node.nil?
		[height(node.left) , height(node.right)].max + 1
	end
end


array = Array.new(15) {rand (0..500)}


def reload  #delete
	load 'balanced_bst.rb'
end

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

class Tree #move to tree.rb
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

	def level_order_print
		array = self.level_order
		array.each {|node| puts node.data}
		return nil
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
		return root if root.nil?

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

	def height(node = @root)
		return -1 if node.nil?
		[height(node.left) , height(node.right)].max + 1
	end

	def depth(key, root = @root, counter = nil)
		if key == root
			return 0
		elsif key < root.data
			depth(key, root.left) + 1
		elsif key > root.data
			depth(key, root.right) + 1
		else
			puts "unable to locate node"
		end
	end

	def balanced?(root = @root)
		return true if root.nil?

		lheight = height(root.left)
		rheight = height(root.right)

		return true if (lheight - rheight).abs <= 1 && balanced?(root.left) && balanced?(root.right)

		false
	end

	def rebalance
		array = self.level_order
		value_array = array.collect {|node| node.data}
		return Tree.new(value_array)
	end
end


#driver_script

# 1. Create a binary search tree from an array of random numbers (`Array.new(15) { rand(1..100) }`)
array = Array.new(15) {rand (0..100)}
bst = Tree.new(array)
bst.pretty_print
# 2. Confirm that the tree is balanced by calling `#balanced?`
puts "is tree balanced?"
puts bst.balanced?
# 3. Print out all elements in level, pre, post, and in order
puts "all elements in level order:"
bst.level_order_print
puts "all elements in preorder:"
bst.preorder.each {|v| puts v}
puts "all elements in postorder:"
bst.postorder.each {|v| puts v}
puts "all elements inorder:"
bst.inorder.each {|v| puts v}
# 4. try to unbalance the tree by adding several numbers > 100
bst.insert(920)
bst.insert(777)
bst.insert(390)
bst.pretty_print
# 5. Confirm that the tree is unbalanced by calling `#balanced?`
puts "is tree balanced?"
puts bst.balanced?
# 6. Balance the tree by calling `#rebalance`
new_bst = bst.rebalance
puts "rebalanced"
new_bst.pretty_print
# 7. Confirm that the tree is balanced by calling `#balanced?`
puts "is tree balanced?"
puts new_bst.balanced?
# 8. Print out all elements in level, pre, post, and in order
puts "all elements in level order:"
new_bst.level_order_print
puts "all elements in preorder:"
new_bst.preorder.each {|v| puts v}
puts "all elements in postorder:"
new_bst.postorder.each {|v| puts v}
puts "all elements inorder:"
new_bst.inorder.each {|v| puts v}










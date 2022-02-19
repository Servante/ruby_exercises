# frozen_string_literal: true


require_relative 'node.rb'
require_relative 'tree.rb'



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
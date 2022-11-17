# frozen_string_literal: true

require_relative 'lib/node'
require_relative 'lib/tree'

array = (Array.new(15) { rand(1..100) }).uniq.sort
tree = Tree.new(array)

puts "Created a tree:\n\n"
tree.pretty_print
puts "\nIs it balanced: #{tree.balanced?}"

puts "\nTraversal orders using blocks:"
tree.level_order { |node| print "#{node} " }; puts
tree.inorder { |node| print "#{node} " }; puts
tree.preorder { |node| print "#{node} " }; puts
tree.postorder { |node| print "#{node} " }; puts

tree.insert(1337)
tree.insert(727)
tree.insert(667)
tree.insert(666)
tree.insert(665)
puts "\nInserted big numbers:\n\n"
tree.pretty_print

puts "\nIs it balanced: #{tree.balanced?}"

tree.rebalance
puts "\nRebalanced the tree:\n\n"
tree.pretty_print

puts "\nTraversal orders without blocks:"
p tree.level_order
p tree.inorder
p tree.preorder
p tree.postorder

tree.delete(666)
puts "\nDeleted node '666':\n\n"
tree.pretty_print

# frozen_string_literal: true

require_relative 'lib/node'
require_relative 'lib/tree'

array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324, 727].uniq.sort
tree = Tree.new(array)

tree.insert(10)
tree.pretty_print

tree.delete(5)
tree.pretty_print

tree.level_order { |node| print "#{node} " }; puts
tree.inorder { |node| print "#{node} " }; puts
p tree.preorder
p tree.postorder

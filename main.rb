# frozen_string_literal: true

require_relative 'lib/node'
require_relative 'lib/tree'

array = [1, 2, 3, 4, 5, 6, 7, 8, 9]

tree = Tree.new(array)
tree.pretty_print
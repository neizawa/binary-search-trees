# frozen_string_literal: true

class Tree
  def initialize(array)
    @root = build_tree(array)
  end

  def build_tree(array, first = 0, last = array.length - 1)
    return nil if first > last

    mid = (first + last) / 2
    node = Node.new(array[mid])
    node.left = build_tree(array, first, mid - 1)
    node.right = build_tree(array, mid + 1, last)
    node
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
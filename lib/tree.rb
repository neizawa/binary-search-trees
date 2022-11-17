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

  def insert(value, node = @root)
    return node.left = Node.new(value) if node.data > value && node.left == nil
    return node.right = Node.new(value) if node.data < value && node.right == nil

    node.data > value ? insert(value, node.left) : insert(value, node.right)
  end

  def delete(value, node = @root)
    if value < node.data
      node.left = delete(value, node.left)
    elsif value > node.data
      node.right = delete(value, node.right)
    else
      return node.right if node.left.nil?
      return node.left if node.right.nil?

      node.data = min_value(node.right)
      node.right = delete(node.data, node.right)
    end

    node
  end

  def min_value(node)
    return node.data if node.left.nil?

    min_value(node.left)
  end

  def find(value, node = @root)
    return node if node.data == value

    node.data > value ? find(value, node.left) : find(value, node.right)
  end
end

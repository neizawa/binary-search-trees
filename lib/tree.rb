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
    return if node.data == value
    return node.left = Node.new(value) if node.data > value && node.left.nil?
    return node.right = Node.new(value) if node.data < value && node.right.nil?

    node.data > value ? insert(value, node.left) : insert(value, node.right)
  end

  def delete(value, node = @root)
    return if node.nil?

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

  def level_order(node = @root)
    queue = []
    arr = []
    queue.push node

    until queue.empty?
      current = queue.first
      queue.push(current.left) unless current.left.nil?
      queue.push(current.right) unless current.right.nil?
      block_given? ? yield(queue.shift.data) : arr.push(queue.shift.data)
    end

    arr unless block_given?
  end

  def inorder(node = @root, arr = [], &block)
    return arr if node.nil?

    inorder(node.left, arr, &block)
    block_given? ? block.call(node.data) : arr.push(node.data)
    inorder(node.right, arr, &block)
  end

  def preorder(node = @root, arr = [], &block)
    return arr if node.nil?

    block_given? ? block.call(node.data) : arr.push(node.data)
    preorder(node.left, arr, &block)
    preorder(node.right, arr, &block)
  end

  def postorder(node = @root, arr = [], &block)
    return arr if node.nil?

    postorder(node.left, arr, &block)
    postorder(node.right, arr, &block)
    block_given? ? block.call(node.data) : arr.push(node.data)
  end

  def height(node, arr = [], count = 0)
    if node.nil?
      arr << count - 1
      return arr.max
    end

    height(node.left, arr, count + 1)
    height(node.right, arr, count + 1)
  end

  def depth(node, root = @root, count = 0)
    return count - 1 if root.nil?

    root.data < node.data ? depth(node, root.left, count + 1) : depth(node, root.right, count + 1)
  end

  def balanced?(node = @root, arr = [])
    return arr.all? { |el| el < 2 } if node.nil?

    left_height = height(node.left)
    right_height = height(node.right)
    arr.push((left_height - right_height).abs)

    balanced?(node.left, arr)
    balanced?(node.right, arr)
  end

  def rebalance
    @root = build_tree(inorder)
  end
end

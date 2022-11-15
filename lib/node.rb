# frozen_string_literal: true

class Node
  attr_accessor :data, :left, :right

  def initialize
    @data = nil
    @left = nil
    @right = nil
  end
end
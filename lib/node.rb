# frozen_string_literal: true

class Node
  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @left = @right = nil
  end
end

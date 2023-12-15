# frozen_string_literal: true

require 'active_support/all'

module Day15
  class Part1
    def solve(input)
      input.split(",").map{|str| hash(str)}.sum
    end

    def hash(str)
      current_value = 0
      str.chars.each do |c|
        current_value += c.bytes.first
        current_value = 17 * current_value
        current_value = current_value % 256
      end
      current_value
    end

  end
end

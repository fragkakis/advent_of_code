# frozen_string_literal: true

module Day1
  class Part1
    def solve(input)
      lines = input.split("\n")
      lines.map do |line|
        chars = line.split('')
        first = chars.find { |c| is_num?(c) }
        last = chars.reverse.find { |c| is_num?(c) }
        (first + last).to_i
      end.sum
    end

    def is_num?(str)
      !!Integer(str)
    rescue ArgumentError, TypeError
      false
    end
  end
end

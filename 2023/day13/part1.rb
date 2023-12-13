# frozen_string_literal: true

require 'active_support/all'

module Day13
  class Part1
    def solve(input)
      patterns = input.split("\n\n").map do |pattern|
        pattern.split("\n").map(&:chars)
      end

      patterns.map { |pattern| calculate(pattern) }.sum
    end

    def calculate(pattern)
      # check for vertical
      horizontal_symmetry_score(pattern.transpose) || 100 * horizontal_symmetry_score(pattern)
    end

    def horizontal_symmetry_score(pattern)
      (1..pattern.size-1).each do |rows_above_mirror|
        return rows_above_mirror if is_mirror_in_line?(pattern, rows_above_mirror)
      end
      nil
    end

    def is_mirror_in_line?(pattern, rows_above_mirror)
      distance_to_border = [rows_above_mirror, pattern.size - rows_above_mirror].min
      (0..distance_to_border - 1).all? do |line|
        pattern[rows_above_mirror - line - 1] == pattern[rows_above_mirror + line]
      end
    end
  end
end

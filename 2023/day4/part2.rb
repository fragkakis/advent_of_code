# frozen_string_literal: true

require 'active_support/all'

module Day4
  class Part2
    attr_reader :lines, :lines_counts

    def solve(input)
      @lines = input.split("\n")
      @lines_counts = {}
      lines.each_with_index do |line, i|
        numeric_part = line.split(':').second
        numbers_arr = numeric_part.split('|')
        winning = numbers_arr.first.strip.split(' ')
        hand = numbers_arr.second.strip.split(' ')
        matches = (winning & hand).size
        increment_line_count(i)
        lines_counts[i].times do
          (1..matches).each do |step|
            increment_line_count(i + step)
          end
        end
      end

      lines_counts.values.sum
    end

    private

    def increment_line_count(i)
      lines_counts[i] = lines_counts[i].present? ? lines_counts[i] + 1 : 1
    end
  end
end

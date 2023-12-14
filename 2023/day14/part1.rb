# frozen_string_literal: true

require 'active_support/all'

module Day14
  class Part1
    def solve(input)
      map = input.split("\n").map(&:chars)
      new_map = tilt_to_left(map.transpose).transpose

      new_map.each{|line| puts(line.join)}

      new_map.each_with_index.map do |line, i|
        line.count("O") * (map.size - i)
      end.sum
    end

    def tilt_to_left(map)
      map.each do |line|
          handle_line(line)
      end
    end

    def handle_line(line)

      loop do
        changed_occured = false
        (0..line.size - 1).each do |position|
          if line[position] == "." && line[position + 1] == "O"

            changed_occured = true
            line[position] = "O"
            line[position + 1] = "."
          end
        end
        break unless changed_occured
      end
    end

  end
end

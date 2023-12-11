# frozen_string_literal: true

require 'active_support/all'

module Day10
  class Part1

    attr_reader :map, :max_x, :max_y

    COMPAT = {
      "right": {
        "S": ["-", "J", "7"],
        "-": ["-", "J", "7", "S"],
        "F": ["-", "J", "7", "S"],
        "L": ["-", "J", "7", "S"]
      },
      "left": {
        "S": ["-", "L", "F", "S"],
        "-": ["-", "L", "F", "S"],
        "J": ["-", "L", "F", "S"],
        "7": ["-", "L", "F", "S"],
      },
      "up": {
        "S": ["|", "F", "7", "S"],
        "|": ["|", "F", "7", "S"],
        "J": ["|", "F", "7", "S"],
        "L": ["|", "F", "7", "S"]
      },
      "down": {
        "S": ["|", "J", "L", "S"],
        "|": ["|", "J", "L", "S"],
        "F": ["|", "J", "L", "S"],
        "7": ["|", "J", "L", "S"]
      }
    }.with_indifferent_access.freeze

    def solve(input)
      @map = input.split("\n").map(&:chars)

      @max_y = map.size
      @max_x = map[0].size

      s_y = nil
      s_x = nil

      (0..max_y-1).each do |y|
        (0...max_x-1).each do |x|
          next unless map[y][x] == "S"
          s_y = y
          s_x = x
          break
        end
      end

      position = [s_y, s_x]
      steps = 0
      visited_positions = []
      previous_value = nil
      loop do
        %w[left right up down].each do |direction|
          neighbor = get_neighbor(position, direction)
          next unless neighbor.present?
          next if visited_positions.include?(neighbor)

          current_y = position[0]
          current_x = position[1]
          current_value = map[current_y][current_x]
          neighbor_y = neighbor[0]
          neighbor_x = neighbor[1]
          neighbor_value = map[neighbor_y][neighbor_x]
          next unless COMPAT[direction][current_value]&.include?(neighbor_value)
          next if neighbor_value == "S" && previous_value == "S"

          steps += 1
          previous_value = current_value
          visited_positions << neighbor
          position = neighbor
          return steps / 2 if neighbor_value == "S"
        end
      end
    end

    private

    def get_neighbor(position, direction)
      neighbor = case direction
                 when "up"
                   [position[0] - 1, position[1]]
                 when "down"
                   [position[0] + 1, position[1]]
                 when "left"
                   [position[0], position[1] - 1]
                 when "right"
                   [position[0], position[1] + 1]
                 else
                   raise "wrong direction"
                 end
      return nil if neighbor[0] > @max_y
      return nil if neighbor[1] > @max_x

      neighbor
    end
  end
end

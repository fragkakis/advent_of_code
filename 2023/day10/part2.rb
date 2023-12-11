# frozen_string_literal: true

require 'active_support/all'

module Day10
  class Part2

    attr_reader :map, :max_x, :max_y, :s_position

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

      @max_y = map.size - 1
      @max_x = map[0].size - 1

      @s_position = compute_s_position
      visited_positions = compute_loop(s_position)

      loop_x_positions_per_y = visited_positions.
        group_by(&:first).
        transform_values{|positions_in_y| positions_in_y.map(&:second).sort}

      # update S with actual value
      possible_s_values_from_start = possible_s_values_from(visited_positions.first)
      possible_s_values_from_end = possible_s_values_from(visited_positions.last(2).first)
      s_value = ((possible_s_values_from_start & possible_s_values_from_end) - ["S"]).first
      map[s_position[0]][s_position[1]] = s_value

      tiles_count = 0

      (0..max_y - 1).each do |y|
        (0...max_x - 1).each do |x|
          next unless loop_x_positions_per_y[y].present?
          next if loop_x_positions_per_y[y].include?(x)
          loop_parts_xes = loop_x_positions_per_y[y].
            select { |loop_x| loop_x < x }

          # L eliminates 7
          # F eliminates J

          vertical_loop_parts_xes = loop_parts_xes.select{ |loop_x| map[y][loop_x] == "|" }
          l_and_7_loop_parts_xes = loop_parts_xes.select{ |loop_x| %w[L 7].include?(map[y][loop_x])}
          f_and_j_loop_parts_xes = loop_parts_xes.select{ |loop_x| %w[F J].include?(map[y][loop_x])}

          if (vertical_loop_parts_xes.size + l_and_7_loop_parts_xes.size/2 + f_and_j_loop_parts_xes.size/2).odd?
            tiles_count += 1
          end
        end
      end
      tiles_count

    end

    private

    def possible_s_values_from(position)
      raise if (position[0] - s_position[0]).abs > 1
      raise if (position[1] - s_position[1]).abs > 1
      direction_to_s = if position[0] < s_position[0]
                         "down"
                       elsif s_position[0] < position[0]
                         "up"
                       elsif position[1] < s_position[1]
                         "right"
                       else
                         "left"
                       end
      COMPAT[direction_to_s][map[position[0]][position[1]]]
    end

    def compute_loop(s_position)
      position = s_position
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

          visited_positions << neighbor
          previous_value = current_value
          previous_position = position
          position = neighbor
          if neighbor_value == "S"
            return visited_positions
          end
        end
      end
    end

    def compute_s_position
      s_y = nil
      s_x = nil

      (0..max_y - 1).each do |y|
        (0...max_x - 1).each do |x|
          next unless map[y][x] == "S"
          s_y = y
          s_x = x
          break
        end
      end
      return [s_y, s_x]
    end

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

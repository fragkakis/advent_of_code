# frozen_string_literal: true

require 'active_support/all'

module Day16
  class Part1
    attr_reader :map, :passes

    POSITION_DIFF = {
      "left" => [0, -1],
      "right" => [0, 1],
      "up" => [-1, 0],
      "down" => [1, 0]
    }.freeze

    NEW_DIRECTIONS = {
      "left" => {
        "." => ["left"],
        "-" => ["left"],
        "/" => ["down"],
        "\\" => ["up"],
        "|" => ["up", "down"]
      },
      "right" => {
        "." => ["right"],
        "-" => ["right"],
        "/" => ["up"],
        "\\" => ["down"],
        "|" => ["up", "down"]
      },
      "up" => {
        "." => ["up"],
        "|" => ["up"],
        "/" => ["right"],
        "\\" => ["left"],
        "-" => ["left", "right"]
      },
      "down" => {
        "." => ["down"],
        "|" => ["down"],
        "/" => ["left"],
        "\\" => ["right"],
        "-" => ["left", "right"]
      }
    }.freeze

    def solve(input)
      @map = input.split("\n").map(&:chars)
      @visited = []
      trace([0, 0], "right")

      @visited.map{|v| v.split("-").first(2).join("-")}.uniq.size
    end

    def trace(position, direction)

      q = [[position, direction]]

      while(q.any?)
        current_position, current_direction = q.shift

        @visited << [current_position[0], current_position[1], current_direction].join("-")
        content = map[current_position[0]][current_position[1]]
        new_directions = NEW_DIRECTIONS[current_direction][content]
        new_directions.each do |new_direction|

          position_diff = POSITION_DIFF[new_direction]
          new_position = [current_position[0] + position_diff[0], current_position[1] + position_diff[1]]

          if position_exists?(new_position) &&
            !@visited.include?([new_position[0], new_position[1], new_direction].join("-"))
            q << [new_position, new_direction]
          end
        end
      end
    end

    def position_exists?(position)
      position[0] >= 0 && position[0] < map.size && position[1] >= 0 && position[1] < map[0].size
    end
  end
end

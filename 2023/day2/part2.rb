# frozen_string_literal: true

module Day2
  class Part2
    def solve(input)
      lines = input.split("\n")
      lines.map do |line|
        power_of_game(line)
      end.sum
    end

    def power_of_game(line)
      color_mins = {
      }
      line.split(':')[1].split(';').each do |set|
        set.split(', ').each do |color_draw|
          number, color = color_draw.split(' ')
          color_num = number.to_i
          color_mins[color] = color_num if !color_mins.key?(color) || color_num > color_mins[color]
        end
      end
      color_mins.values.inject(:*)
    end
  end
end

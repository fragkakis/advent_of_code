# frozen_string_literal: true

module Day2
  class Part1

    MAX = {
      "red" => 12,
      "green" => 13,
      "blue" => 14
    }.freeze

    def solve(input)
      lines = input.split("\n")
      sum = 0
      lines.map do |line|
        sum += id_for_game(line) if is_game_possible?(line)
      end
      sum
    end

    def id_for_game(line)
      line.split(':')[0].gsub("Game ", '').to_i
    end

    def is_game_possible?(line)
      line.split(':')[1].split(';').each do |set|
        return false unless is_set_possible?(set)
      end
      true
    end

    def is_set_possible?(set)
      set.split(', ').each do |color_draw|
        number, color = color_draw.split(' ')
        return false if number.to_i > MAX[color]
      end
      true
    end
  end
end

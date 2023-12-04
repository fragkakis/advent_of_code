require "active_support/all"

module Day4
  class Part1

    attr_reader :lines

    def solve(input)
      @lines = input.split("\n")
      lines.map do |line|
        numeric_part = line.split(":").second
        numbers_arr = numeric_part.split("|")
        winning = numbers_arr.first.strip.split(" ")
        hand = numbers_arr.second.strip.split(" ")
        matches = (winning & hand).size
        if matches > 0
          2 ** (matches-1)
        else
          0
        end

      end.sum

    end

    private

  end
end

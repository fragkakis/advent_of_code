require "active_support/all"

module Day3
  class Part2

    attr_reader :lines

    def solve(input)
      @lines = input.split("\n")
      gear_to_neighboring_numbers = {}

      lines.each_with_index do |line, line_num|
        current_num = ""
        line.chars.each_with_index do |char, char_pos|
          if is_number?(char)
            current_num += char
          else
            if current_num.present?
              adjacent_gear_coords(line_num, char_pos - current_num.length, char_pos - 1).each do |coords|
                gear_to_neighboring_numbers[coords] = [] unless gear_to_neighboring_numbers.key?(coords)

                gear_to_neighboring_numbers[coords] << current_num.to_i
              end
            end
            current_num = ""
          end
        end
      end
      sum = 0
      gear_to_neighboring_numbers.each do |gear_coords, numbers|
        next unless numbers.size == 2
        sum += numbers[0] * numbers[1]
      end
      sum
    end

    private

    def adjacent_gear_coords(line_num, start_pos, end_pos)
      adjacent_gear_coords = []
      neighbor_coords(line_num, start_pos, end_pos).any? do |coords|
        if is_gear?(engine_as_array[coords[0]][coords[1]])
          adjacent_gear_coords << coords
        end
      end
      adjacent_gear_coords
    end

    def neighbor_coords(line_num, start_pos, end_pos)
      neighbor_coords = []
      neighbor_coords << [line_num, start_pos - 1]
      neighbor_coords << [line_num - 1, start_pos - 1]
      neighbor_coords << [line_num + 1, start_pos - 1]
      neighbor_coords << [line_num, end_pos + 1]
      neighbor_coords << [line_num - 1, end_pos + 1]
      neighbor_coords << [line_num + 1, end_pos + 1]
      (start_pos..end_pos).each do |pos|
        neighbor_coords << [line_num - 1, pos]
        neighbor_coords << [line_num + 1, pos]
      end

      neighbor_coords.select do |coords|
        0 <= coords[0] && coords[0] < lines.size &&
          0 <= coords[1] && coords[1] < lines[0].size
      end
    end

    def engine_as_array
      return @engine_as_array if defined? @engine_as_array

      @engine_as_array = []
      lines.each_with_index do |line, line_num|
        @engine_as_array[line_num] = line.chars
      end
      @engine_as_array
    end

    def is_gear?(string)
      string == '*'
    end

    def is_number? string
      true if Float(string) rescue false
    end

  end
end

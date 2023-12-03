require "active_support/all"

module Day3
  class Part1

    attr_reader :lines

    def solve(input)
      @lines = input.split("\n")
      engine_parts = []

      lines.each_with_index do |line, line_num|
        current_num = ""
        line.chars.each_with_index do |char, char_pos|
          if is_number?(char)
            current_num += char
          else
            if current_num.present?
              if is_adjacent_to_symbol?(line_num, char_pos - current_num.length, char_pos - 1)
                engine_parts << current_num.to_i
              end
            end
            current_num = ""
          end
        end
      end
      engine_parts.sum
    end

    private

    def is_adjacent_to_symbol?(line_num, start_pos, end_pos)
      neighbor_coords(line_num, start_pos, end_pos).any? do |coords|
        is_symbol?(engine_as_array[coords[0]][coords[1]])
      end
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

    def is_symbol?(string)
      return false if string == '.'
      return false if is_number?(string)
      true
    end
    def is_number? string
      true if Float(string) rescue false
    end

  end
end

# frozen_string_literal: true

require 'active_support/all'

module Day11
  class Part1
    def solve(input)
      map = input.split("\n").map(&:chars)
      expand(map)
      galaxies = find_galaxies(map)
      galaxies.combination(2).to_a.map do |galaxy_pair|
        g0 = galaxy_pair[0]
        g1 = galaxy_pair[1]
        (g0[0] - g1[0]).abs + (g0[1] - g1[1]).abs
      end.sum
    end

    private

    def find_galaxies(map)
      positions = []
      map.each_with_index do |row, row_num|
        row.each_with_index do |tile, col_num|
          positions << [row_num, col_num] if tile == "#"
        end
      end
      positions
    end

    def expand(map)
      empty_rows = map.each_with_index.map { |row, row_num| row.all? { |c| c == '.' } ? row_num : nil }.compact
      puts "empty rows: #{empty_rows}"

      original_row_num = map.size - 1
      original_col_num = map[0].size - 1

      empty_columns = (0..(original_col_num)).map do |col_num|
        next unless (0..original_row_num).all? do |row_num|
          map[row_num][col_num] == '.'
        end
        col_num
      end.compact
      puts "empty columns: #{empty_columns}"

      # add empty columns
      empty_columns.sort.reverse.each do |col_num|
        (0..original_row_num).each do |row_num|
          map[row_num].insert(col_num, ".")
        end
      end

      new_col_num = original_col_num + empty_columns.size
      # add empty rows
      empty_rows.sort.reverse.each do |row_num|
        map.insert(row_num, ["."] * new_col_num)
      end
    end
  end
end

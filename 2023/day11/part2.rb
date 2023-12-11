# frozen_string_literal: true

require 'active_support/all'

module Day11
  class Part2
    TIMES = 1_000_000

    def solve(input)
      map = input.split("\n").map(&:chars)
      empty_rows, empty_columns = empty_rows_and_columns(map)
      galaxies = find_galaxies(map)
      galaxies.combination(2).to_a.map do |galaxy_pair|
        g0 = galaxy_pair[0]
        g1 = galaxy_pair[1]
        min_row = [g0[0], g1[0]].min
        max_row = [g0[0], g1[0]].max
        min_col = [g0[1], g1[1]].min
        max_col = [g0[1], g1[1]].max

        empty_rows_between_galaxies = empty_rows.select { |row_num| min_row < row_num && row_num < max_row }.size
        empty_cols_between_galaxies = empty_columns.select { |col_num| min_col < col_num && col_num < max_col }.size
        row_distance = (max_row - min_row + (TIMES - 1) * empty_rows_between_galaxies)
        col_distance = (max_col - min_col + (TIMES - 1) * empty_cols_between_galaxies)
        row_distance + col_distance
      end.sum
    end

    private

    def find_galaxies(map)
      positions = []
      map.each_with_index do |row, row_num|
        row.each_with_index do |tile, col_num|
          positions << [row_num, col_num] if tile == '#'
        end
      end
      positions
    end

    def empty_rows_and_columns(map)
      empty_rows = map.each_with_index.map { |row, row_num| row.all? { |c| c == '.' } ? row_num : nil }.compact
      puts "empty rows: #{empty_rows}"

      original_max_row_num = map.size - 1
      original_max_col_num = map[0].size - 1

      empty_columns = (0..original_max_col_num).map do |col_num|
        next unless (0..original_max_row_num).all? do |row_num|
          map[row_num][col_num] == '.'
        end

        col_num
      end.compact
      puts "empty columns: #{empty_columns}"

      [empty_rows, empty_columns]
    end
  end
end

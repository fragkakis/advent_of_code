# frozen_string_literal: true

require 'active_support/all'

module Day13
  class Part2
    def solve(input)
      patterns = input.split("\n\n").map do |pattern|
        pattern.split("\n").map(&:chars)
      end

      patterns.map { |pattern| calculate(pattern) }.sum
    end

    def calculate(pattern)
      row_size = pattern.size
      col_size = pattern[0].size

      old_score = score(pattern, nil)
      (0..row_size - 1).each do |smudge_row|
        (0..col_size - 1).each do |smudge_col|

          smudgless_pattern = Marshal.load(Marshal.dump(pattern))
          prev_value = smudgless_pattern[smudge_row][smudge_col]
          smudgless_pattern[smudge_row][smudge_col] = prev_value == "." ? "#" : "."
          smudgeless_score = score(smudgless_pattern, old_score)
          next if smudgeless_score.blank? || old_score == smudgeless_score
          return smudgeless_score
        end
      end
      nil
    end

    def score(pattern, ignore_score = nil)
      vertical_score = horizontal_symmetry_score(pattern.transpose, ignore_score)
      return vertical_score if vertical_score.present?

      horizontal_score = horizontal_symmetry_score(pattern, ignore_score ? ignore_score/100 : nil)
      return 100 * horizontal_score if horizontal_score.present?

      return nil
    end

    def horizontal_symmetry_score(pattern, ignore_rows_above_mirror)
      (1..pattern.size-1).each do |rows_above_mirror|
        next if rows_above_mirror == ignore_rows_above_mirror
        return rows_above_mirror if is_mirror_in_line?(pattern, rows_above_mirror)
      end
      nil
    end

    def is_mirror_in_line?(pattern, rows_above_mirror)
      distance_to_border = [rows_above_mirror, pattern.size - rows_above_mirror].min
      (0..distance_to_border - 1).all? do |line|
        pattern[rows_above_mirror - line - 1] == pattern[rows_above_mirror + line]
      end
    end
  end
end

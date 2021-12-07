module Day3
  class Part2
    def solve(input)
      report_lines = input.split("\n")

      position = 0
      report_lines_for_oxygen_generator_rating = report_lines.dup
      while report_lines_for_oxygen_generator_rating.size > 1
        report_lines_for_oxygen_generator_rating = narrow_down_with_most_common(report_lines_for_oxygen_generator_rating, position)
        position += 1
      end
      oxygen_generator_rating = report_lines_for_oxygen_generator_rating.first.to_i(2)

      position = 0
      report_lines_for_co2_scrubber_rating = report_lines.dup
      while report_lines_for_co2_scrubber_rating.size > 1
        report_lines_for_co2_scrubber_rating = narrow_down_with_least_common(report_lines_for_co2_scrubber_rating, position)
        position += 1
      end
      co2_scrubber_rating = report_lines_for_co2_scrubber_rating.first.to_i(2)

      oxygen_generator_rating * co2_scrubber_rating
    end

    def narrow_down_with_most_common(report_lines, position)
      bits = report_lines.map { |rl| rl[position] }
      bit_occurrences = bits.each_with_object(Hash.new(0)) { |v, h|
        h[v] += 1
      }

      filter_bit = if bit_occurrences["0"] == bit_occurrences["1"]
        "1"
      else
        bit_occurrences.max_by(&:last).first
      end

      report_lines.select { |rl| rl[position] == filter_bit }
    end

    def narrow_down_with_least_common(report_lines, position)
      bits = report_lines.map { |rl| rl[position] }
      bit_occurrences = bits.each_with_object(Hash.new(0)) { |v, h|
        h[v] += 1
      }

      filter_bit = if bit_occurrences["0"] == bit_occurrences["1"]
        "0"
      else
        bit_occurrences.min_by(&:last).first
      end

      report_lines.select { |rl| rl[position] == filter_bit }
    end
  end
end

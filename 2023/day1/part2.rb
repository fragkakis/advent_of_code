# frozen_string_literal: true

module Day1
  class Part2
    REGEX = /(\d|zero|one|two|three|four|five|six|seven|eight|nine|)/.freeze
    MAPPING = {
      'zero' => 0,
      'one' => 1,
      'two' => 2,
      'three' => 3,
      'four' => 4,
      'five' => 5,
      'six' => 6,
      'seven' => 7,
      'eight' => 8,
      'nine' => 9
    }.freeze

    def solve(input)
      lines = input.split("\n")
      lines.map do |line|
        matches = line.scan(REGEX).reject { |m| m == [''] }
        first_match = matches.first[0]
        first = is_num?(first_match) ? first_match : MAPPING.fetch(first_match)

        last_match = matches.last[0]
        last = is_num?(last_match) ? last_match : MAPPING.fetch(last_match)

        "#{first}#{last}".to_i
      end.sum
    end

    private

    def is_num?(str)
      !!Integer(str)
    rescue ArgumentError, TypeError
      false
    end
  end
end

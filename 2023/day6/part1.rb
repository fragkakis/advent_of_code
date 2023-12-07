require "active_support/all"

module Day6
  class Part1

    def solve(input)
      lines = input.split("\n")
      times = lines[0].gsub("Time:", "").squish.split(" ").map(&:to_i)
      record_distances = lines[1].gsub("Distance:", "").squish.split(" ").map(&:to_i)

      times.each_with_index.map do |time, i|
        record_distance = record_distances[i]
        solutions = 0
        (0..time-1).each do |charging_time|
          distance = charging_time * time - charging_time ** 2
          if distance > record_distance
            solutions += 1
          end
        end
        solutions
      end.inject(:*)
    end

  end
end

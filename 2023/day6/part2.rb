require "active_support/all"

module Day6
  class Part2

    def solve(input)
      lines = input.split("\n")
      time = lines[0].gsub("Time:", "").gsub(" ", "").to_i
      record_distance = lines[1].gsub("Distance:", "").gsub(" ", "").to_i
      solutions = 0
      (0..time-1).each do |charging_time|
        distance = charging_time * time - charging_time ** 2
        if distance > record_distance
          solutions += 1
        end
      end
      solutions
    end

  end
end

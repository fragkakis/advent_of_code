module Day7
  class Part2
    def solve(input)
      positions = input.split(",").map(&:to_i)

      min_x = positions.min
      max_x = positions.max

      costs = []
      (min_x..max_x).each do |x|
        costs << calculate_cost_for(x, positions)
      end
      costs.min
    end

    def calculate_cost_for(x, positions)
      positions
        .map { |crab_x| (crab_x - x).abs }
        .select(&:positive?)
        .map { |distance| (1..distance).sum }
        .sum
    end
  end
end

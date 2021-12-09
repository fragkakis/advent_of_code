module Day9
  class Part1
    def solve(input)
      heightmap = input.split("\n").map { |line| line.chars.map(&:to_i) }
      x_size = heightmap.size
      y_size = heightmap[0].size
      low_heights = []

      (0..x_size - 1).each do |x|
        (0..y_size - 1).each do |y|
          adjacent_coords = [
            [x - 1, y],
            [x + 1, y],
            [x, y - 1],
            [x, y + 1]
          ].reject { |coords| coords.any?(&:negative?) }
            .reject { |coords| coords[0] > x_size - 1 }
            .reject { |coords| coords[1] > y_size - 1 }

          low_heights << heightmap[x][y] if adjacent_coords.all? { |coord| heightmap[x][y] < heightmap[coord[0]][coord[1]] }
        end
      end

      low_heights.map {|height| height + 1}.sum
    end

  end
end

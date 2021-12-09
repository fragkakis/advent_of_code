module Day9
  class Part2

    attr_reader :heightmap, :x_size, :y_size

    def solve(input)
      @heightmap = input.split("\n").map { |line| line.chars.map(&:to_i) }
      @x_size = heightmap.size
      @y_size = heightmap[0].size
      low_coords = []

      (0..x_size - 1).each do |x|
        (0..y_size - 1).each do |y|
          adjacent_coords = adjacent_coords(x, y)
          low_coords << [x, y] if adjacent_coords.all? { |coord| heightmap[x][y] < heightmap[coord[0]][coord[1]] }
        end
      end

      basins = low_coords.map { |x, y| basin_for(x, y) }
      basin_sizes = basins.map(&:size)
      basin_sizes.sort.last(3).inject(:*)
    end

    def basin_for(x, y)
      basin = [[x, y]]
      coords_added_in_last_sweep = [[x, y]]

      loop do
        coords_to_add = []
        coords_added_in_last_sweep.each do |coords|
          adjacent_coords(coords[0], coords[1]).each do |adjacent_coords|
            next if basin.include?(adjacent_coords)
            next if coords_to_add.include?(adjacent_coords)
            next if heightmap[adjacent_coords[0]][adjacent_coords[1]] == 9

            coords_to_add << adjacent_coords if heightmap[coords[0]][coords[1]] < heightmap[adjacent_coords[0]][adjacent_coords[1]]
          end
        end
        break if coords_to_add.empty?
        basin += coords_to_add
        coords_added_in_last_sweep = coords_to_add
      end
      basin
    end

    def adjacent_coords(x, y)
      [
        [x - 1, y],
        [x + 1, y],
        [x, y - 1],
        [x, y + 1]
      ].reject { |coords| coords.any?(&:negative?) }
        .reject { |coords| coords[0] > x_size - 1 }
        .reject { |coords| coords[1] > y_size - 1 }
    end

  end
end

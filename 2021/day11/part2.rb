class Part2

  STEPS = [-1, 0, 1].freeze

  attr_reader :grid, :flashes

  def solve(input)
    @grid = input.split("\n").map { |line| line.chars.map(&:to_i) }
    total_octopi = @grid.size * @grid[0].size
    i = 0
    loop do
      i += 1
      new_flashes = evolve
      return i if new_flashes == total_octopi
    end
  end

  def evolve
    (0..grid.size - 1).each do |row|
      (0..grid[0].size - 1).each do |col|
        grid[row][col] += 1
        flash(row, col) if grid[row][col] == 10
      end
    end
    count_and_reset_flashed
  end

  def flash(row, col)
    neighbors(row, col).each do |n_row, n_col|
      grid[n_row][n_col] += 1
      if grid[n_row][n_col] == 10
        flash(n_row, n_col)
      end
    end
  end

  def neighbors(row, col)
    neighbor_rows = STEPS.map { |s| row + s }
    neighbor_cols = STEPS.map { |s| col + s }
    neighbor_rows.product(neighbor_cols).
      reject { |coords| coords.any?(&:negative?) }.
      reject { |coords| coords[0] > grid.size - 1 }.
      reject { |coords| coords[1] > grid[0].size - 1 } - [row, col]
  end

  def count_and_reset_flashed
    new_flashes = 0
    (0..grid.size - 1).each do |row|
      (0..grid[0].size - 1).each do |col|
        if grid[row][col] >= 10
          new_flashes += 1
          grid[row][col] = 0
        end
      end
    end
    new_flashes
  end

end

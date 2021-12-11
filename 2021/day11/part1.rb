class Part1

  STEPS = [-1, 0, 1].freeze

  attr_reader :grid, :flashes

  def solve(input)
    @grid = input.split("\n").map { |line| line.chars.map(&:to_i) }
    @flashes = 0
    100.times do
      evolve
    end
    flashes
  end

  def evolve
    (0..grid.size - 1).each do |row|
      (0..grid[0].size - 1).each do |col|
        grid[row][col] += 1
        flash(row, col) if grid[row][col] == 10
      end
    end
    reset_flashed
    flashes
  end

  def flash(row, col)
    @flashes += 1
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

  def reset_flashed
    (0..grid.size - 1).each do |row|
      (0..grid[0].size - 1).each do |col|
        if grid[row][col] >= 10
          grid[row][col] = 0
        end
      end
    end
  end

end

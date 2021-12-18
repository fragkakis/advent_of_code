class Part1

  INFINITY = 10_000_000_000_000
  attr_reader :cavern

  def solve(input)
    @cavern = input.split("\n").map { |line| line.chars.map(&:to_i) }

    distance_from_start = {}
    unvisited = []
    (0..cavern.size-1).each do |x|
      (0..cavern.size-1).each do |y|
        distance_from_start[key([x, y])] = INFINITY
        unvisited << [x, y]
      end
    end

    cavern[0][0] = 0 # 0 cost for start
    start = [0, 0]
    distance_from_start[key(start)] = 0
    finish = [cavern.size - 1, cavern.size - 1]

    while unvisited.any?
      next_in_path = unvisited.min_by{|coord| distance_from_start[key(coord)]}
      unvisited.delete(next_in_path)
      neighbors = neighbors(next_in_path)

      (neighbors & unvisited).each do |neighbor|
        alt_neighbor_distance = distance_from_start[key(next_in_path)] + cavern[neighbor[0]][neighbor[1]]
        previously_known_neighbor_distance = distance_from_start[key(neighbor)]
        if alt_neighbor_distance < previously_known_neighbor_distance
          distance_from_start[key(neighbor)] = alt_neighbor_distance
        end
      end
    end

    distance_from_start[key(finish)]
  end

  def key(coord)
    "#{coord[0]}_#{coord[1]}"
  end

  def neighbors(coord)
    [
      [coord[0] + 1, coord[1]],
      [coord[0] - 1, coord[1]],
      [coord[0], coord[1] + 1],
      [coord[0], coord[1] - 1]
    ]
      .reject { |neighbor| neighbor.any?(&:negative?) }
      .reject { |neighbor| neighbor[0] > cavern.size - 1 || neighbor[1] > cavern.size - 1 }
  end
end

class Part2

  INFINITY = 10_000_000_000_000
  attr_reader :cavern_max_size

  def solve(input)

    tile = input.split("\n").map { |line| line.chars.map(&:to_i) }
    cavern = build_cavern(tile)
    @cavern_max_size = cavern.size - 1
    return lowest_risk(cavern)
  end

  def build_cavern(top_left_tile)
    cavern_size = top_left_tile.size * 5

    cavern = []
    cavern_size.times do
      x = []
      cavern_size.times do
        x << 0
      end
      cavern << x
    end

    # copy top left tile
    (0..top_left_tile.size-1).each do |x|
      (0..top_left_tile.size-1).each do |y|
        cavern[x][y] = top_left_tile[x][y]
      end
    end

    (0..4).each do |x_tile|
      (0..4).each do |y_tile|
        next if x_tile == 0 && y_tile == 0 # already there
        # building a tile
        (0..top_left_tile.size-1).each do |top_left_x|
          (0..top_left_tile.size-1).each do |top_left_y|
            if x_tile == 0
              # get it from above
              origin_x = x_tile * top_left_tile.size + top_left_x
              origin_y = (y_tile - 1) * top_left_tile.size + top_left_y
            else
              # get it from left
              origin_x = (x_tile - 1) * top_left_tile.size + top_left_x
              origin_y = y_tile * top_left_tile.size + top_left_y
            end
            new_x = (x_tile * top_left_tile.size) + top_left_x
            new_y = (y_tile * top_left_tile.size) + top_left_y
            cavern[new_x][new_y] = increase_and_wrap(cavern[origin_x][origin_y])
          end
        end

      end
    end
    cavern
  end

  def increase_and_wrap(number)
    return 1 if number == 9
    number + 1
  end

  def lowest_risk(cavern)
    distance_from_start = {}
    unvisited = []
    cavern_hash = {}
    (0..cavern_max_size).each do |x|
      (0..cavern_max_size).each do |y|
        key = key([x, y])
        distance_from_start[key] = INFINITY
        unvisited << key
        cavern_hash[key] = cavern[x][y]
      end
    end

    cavern[0][0] = 0 # 0 cost for start
    start = [0, 0]
    distance_from_start[key(start)] = 0
    finish = [cavern_max_size, cavern_max_size]

    while unvisited.any?
      next_in_path_key = unvisited.min_by { |coord_key| distance_from_start[coord_key] }
      unvisited.delete(next_in_path_key)
      neighbor_keys = neighbors(next_in_path_key.split("_").map(&:to_i)).map{ |n| key(n) }

      distance_for_next_in_path = distance_from_start[next_in_path_key]
      (neighbor_keys & unvisited).each do |neighbor_key|
        alt_neighbor_distance = distance_for_next_in_path + cavern_hash[neighbor_key]
        previously_known_neighbor_distance = distance_from_start[neighbor_key]
        if alt_neighbor_distance < previously_known_neighbor_distance
          distance_from_start[neighbor_key] = alt_neighbor_distance
        end
      end
    end

    distance_from_start[key(finish)]
  end

  def key(coord)
    "#{coord[0]}_#{coord[1]}"
  end

  def neighbors(coord)
    # contains invalid neighbors, but no value will be found for them
    [
      [coord[0] + 1, coord[1]],
      [coord[0] - 1, coord[1]],
      [coord[0], coord[1] + 1],
      [coord[0], coord[1] - 1]
    ]
  end

end

module Day1
  class Part2
    DIRECTIONS = %w[N E S W]

    attr_reader :state

    def solve(input)
      @state = initial_state
      moves = input.split(", ")
      catch :found do
        moves.inject(state) { |state, m| move(state, m) }
      end

      state[:visited_coordinates].last[0].abs + state[:visited_coordinates].last[1].abs
    end

    def move(state, move)
      state[:direction] = new_direction(state[:direction], move)
      case state[:direction]
      when "N"
        new_vertical_offset = state[:vertical_offset] + steps(move)
        (state[:vertical_offset] + 1..new_vertical_offset).to_a.each { |o| record_visit(state[:visited_coordinates], [state[:horizontal_offset], o]) }
        state[:vertical_offset] = new_vertical_offset
      when "S"
        new_vertical_offset = state[:vertical_offset] - steps(move)
        (new_vertical_offset...state[:vertical_offset]).to_a.reverse_each { |o| record_visit(state[:visited_coordinates], [state[:horizontal_offset], o]) }
        state[:vertical_offset] = new_vertical_offset
      when "E"
        new_horizontal_offset = state[:horizontal_offset] + steps(move)
        (state[:horizontal_offset] + 1..new_horizontal_offset).to_a.each { |o| record_visit(state[:visited_coordinates], [o, state[:vertical_offset]]) }
        state[:horizontal_offset] = new_horizontal_offset
      else
        # 'W'
        new_horizontal_offset = state[:horizontal_offset] - steps(move)
        (new_horizontal_offset...state[:horizontal_offset]).to_a.reverse_each { |o| record_visit(state[:visited_coordinates], [o, state[:vertical_offset]]) }
        state[:horizontal_offset] = new_horizontal_offset
      end
      state
    end

    def record_visit(visited_coordinates, coordinates, &block)
      visited_coordinates << coordinates
      if visited_coordinates.count(coordinates) > 1
        throw :found
      end
    end

    def initial_state
      {
        horizontal_offset: 0,
        vertical_offset: 0,
        direction: "N",
        visited_coordinates: []
      }
    end

    def steps(move)
      move.sub("R", "").sub("L", "").to_i
    end

    def new_direction(current_direction, move)
      current_index = DIRECTIONS.index(current_direction)
      case move[0]
      when "R"
        DIRECTIONS[(current_index + 1) % 4]
      else
        DIRECTIONS[(current_index - 1) % 4]
      end
    end
  end
end

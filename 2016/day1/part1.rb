module Day1
  class Part1

    DIRECTIONS = %w(N E S W)

    def solve(input)
      moves = input.split(', ')
      final_state = moves.inject(initial_state){|state, m| move(state, m)}
      final_state[:horizontal_offset].abs + final_state[:vertical_offset].abs
     end

    def initial_state
      {
          horizontal_offset: 0,
          vertical_offset: 0,
          direction: 'N'
      }
    end

    def move(state, move)
      state[:direction] = new_direction(state[:direction], move)
      case state[:direction]
      when 'N'
        state[:vertical_offset] += steps(move)
      when 'S'
        state[:vertical_offset] -= steps(move)
      when 'E'
        state[:horizontal_offset] += steps(move)
      else # 'W'
        state[:horizontal_offset] -= steps(move)
      end
      state
    end

    def steps(move)
      move.sub('R', '').sub('L', '').to_i
    end

    def new_direction(current_direction, move)
      current_index = DIRECTIONS.index(current_direction)
      case move[0]
      when 'R'
        DIRECTIONS[(current_index + 1) % 4]
      else
        DIRECTIONS[(current_index - 1) % 4]
      end
    end
  end
end
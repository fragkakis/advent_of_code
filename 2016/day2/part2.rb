module Day2
  class Part2

    KEYPAD = [[nil, nil, 'D', nil, nil], [nil, 'A', 'B', 'C', nil], [5, 6, 7, 8, 9], [nil, 2, 3, 4, nil], [nil, nil, 1, nil, nil]]

    def solve(input)
      lines = input.split("\n")
      final_state = lines.inject(initial_state){|state, line| find_button(state, line)}
      final_state[:code]
     end

    def initial_state
      {
          x: 0,
          y: 2,
          code: ''
      }
    end

    def find_button(state, line)
      line.split('').each{|m| move(state, m)}
      state[:code] << KEYPAD[state[:y]][state[:x]].to_s
      state
    end

    def move(state, move)
      x = state[:x]
      y = state[:y]
      case move
        when 'U'
          y = [y+1, 4].min
        when 'D'
          y = [y-1, 0].max
        when 'L'
          x = [x-1, 0].max
        else # 'R'
          x = [x+1, 4].min
      end
      if KEYPAD[y][x]
        state[:x] = x
        state[:y] = y
      end
    end
  end
end
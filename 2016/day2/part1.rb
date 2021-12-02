module Day2
  class Part1

    KEYPAD = [[7, 8, 9], [4, 5, 6], [1, 2, 3]]

    def solve(input)
      lines = input.split("\n")
      final_state = lines.inject(initial_state){|state, line| find_button(state, line)}
      final_state[:code]
     end

    def initial_state
      {
          x: 1,
          y: 1,
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
          y = [y+1, 2].min
        when 'D'
          y = [y-1, 0].max
        when 'L'
          x = [x-1, 0].max
        else # 'R'
          x = [x+1, 2].min
      end
      state[:x] = x
      state[:y] = y
    end
  end
end
module Day2
  class Part1
    def solve(input)
      horizintal_position = 0
      depth = 0
      instructions = input.split("\n").map { |line| line.split(" ") }

      instructions.each do |instruction, x|
        case instruction
        when "forward"
          horizintal_position += x.to_i
        when "down"
          depth += x.to_i
        when "up"
          depth -= x.to_i
        end
      end
      horizintal_position * depth
    end
  end
end

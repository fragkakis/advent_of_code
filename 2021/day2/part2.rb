module Day2
  class Part2
    def solve(input)
      horizontal_position = 0
      depth = 0
      aim = 0
      instructions = input.split("\n").map { |line| line.split(" ") }

      instructions.each do |instruction, x|
        case instruction
        when "forward"
          horizontal_position += x.to_i
          depth += aim * x.to_i
        when "down"
          aim += x.to_i
        when "up"
          aim -= x.to_i
        end
      end
      horizontal_position * depth
    end
  end
end

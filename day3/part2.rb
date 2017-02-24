module Day3
  class Part2

    def solve(input)
      lines = input.split("\n")
      valid_count = 0
      (0..lines.length - 1).step(3).each do |index|
        edges0 = line_to_edges(lines[index])
        edges1 = line_to_edges(lines[index + 1])
        edges2 = line_to_edges(lines[index + 2])

        valid_count += 1 if valid?([edges0[0], edges1[0], edges2[0]])
        valid_count += 1 if valid?([edges0[1], edges1[1], edges2[1]])
        valid_count += 1 if valid?([edges0[2], edges1[2], edges2[2]])
      end
      valid_count
    end

    def line_to_edges(line)
      line.split(' ').map(&:to_i)
    end

    def valid?(sides)
      (sides[0] < sides[1] + sides[2]) && (sides[1] < sides[0] + sides[2]) && (sides[2] < sides[0] + sides[1])
    end
  end
end
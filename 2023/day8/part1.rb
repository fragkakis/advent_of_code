# frozen_string_literal: true

require 'active_support/all'

module Day8
  class Part1

    def solve(input)
      lines = input.split("\n")
      instructions = lines[0].chars

      nodes = {}
      lines[2..].each do |line|
        line =~ /(\w+)\s=\s\((\w+),\s(\w+)\)/
        nodes[$1] = [$2, $3]
      end

      steps = 0
      current_node = "AAA"
      loop do
        instructions.each do |instruction|
          current_node = nodes[current_node][instruction == "L" ? 0 : 1]
          steps += 1
          return steps if current_node == "ZZZ"
        end
      end
    end


  end
end

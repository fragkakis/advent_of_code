# frozen_string_literal: true

require 'active_support/all'

module Day8
  class Part2

    def solve(input)
      lines = input.split("\n")
      @instructions = lines[0].chars

      @nodes = {}
      lines[2..].each do |line|
        line =~ /(\w+)\s=\s\((\w+),\s(\w+)\)/
        @nodes[$1] = [$2, $3]
      end

      starting_nodes = @nodes.keys.select{|n| n.ends_with?("A")}
      steps_for_nodes = starting_nodes.map do |starting_node|
        steps_for_node(starting_node)
      end
      steps_for_nodes.reduce(1, :lcm)
    end

    def steps_for_node(node)
      steps = 0
      current_node = node
      loop do
        @instructions.each do |instruction|
          current_node = @nodes[current_node][instruction == "L" ? 0 : 1]
          steps += 1
          return steps if current_node.ends_with?("Z")
        end
      end
    end
  end
end

class Part1

  def solve(input)

    polymer_str, mappings_str = input.split("\n\n")
    mappings = mappings_str.split("\n").map{|m| m.split(" -> ")}.to_h

    polymer = polymer_str.chars
    10.times do
      polymer = polymer.each_cons(2).map{|c1, c2| [c1, mappings["#{c1}#{c2}"]]}.flatten + [polymer.last]
    end
    occurrences = polymer.tally.values.sort
    occurrences.last - occurrences.first
  end
end

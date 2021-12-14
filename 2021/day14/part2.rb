class Part2

  def solve(input)

    polymer_str, mappings_str = input.split("\n\n")
    mappings = mappings_str.split("\n").map{|m| m.split(" -> ")}.to_h

    couples = Hash.new{0}
    polymer_str.chars.each_cons(2).each do |c1, c2|
      couples["#{c1}#{c2}"] += 1
    end
    first_char = polymer_str.chars.first
    last_char = polymer_str.chars.last

    40.times do
      next_round_couples = Hash.new{0}
      couples.each do |couple, occurrences|
        intermediate_char = mappings[couple]
        next_round_couples["#{couple.chars[0]}#{intermediate_char}"] += occurrences
        next_round_couples["#{intermediate_char}#{couple.chars[1]}"] += occurrences
      end
      couples = next_round_couples
    end

    # each char except the first and last are counted twice as part of 2 pairs
    double_occurrences_per_char = Hash.new{0}
    couples.each do |couple, occurrences|
      double_occurrences_per_char[couple[0]] += occurrences
      double_occurrences_per_char[couple[1]] += occurrences
    end
    # compensate the first and last char
    double_occurrences_per_char[first_char] += 1
    double_occurrences_per_char[last_char] += 1

    sorted_values = double_occurrences_per_char.values.map{|v| v/2}.sort
    sorted_values.last - sorted_values.first
  end
end

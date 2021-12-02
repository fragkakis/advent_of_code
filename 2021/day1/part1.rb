module Day1
  class Part1

    def solve(input)
      counter = 0
      measurements = input.split("\n").map(&:to_i)
      measurements.each_cons(2).to_a.each do |pair|
        counter += 1 if pair[1] > pair[0]
      end
      counter
    end
  end
end

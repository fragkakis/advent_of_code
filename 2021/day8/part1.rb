module Day8
  class Part1
    def solve(input)
      output_signals = input.split("\n").map{|line| line.split(" | ")[1].split(" ")}.flatten
      output_signals.select{|signal| digit_of_interest?(signal)}.size
    end

    def digit_of_interest?(signal)
      [2, 3, 4, 7].include?(signal.length)
    end
  end
end

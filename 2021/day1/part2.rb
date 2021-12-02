module Day1
  class Part2

    def solve(input)
      counter = 0
      measurements = input.split("\n").map(&:to_i)
      measurements.each_cons(4).to_a.each do |sliding_window|
        first_window_sum = sliding_window[0..2].sum
        second_window_sum = sliding_window[1..3].sum
        counter += 1 if second_window_sum > first_window_sum
      end
      counter
    end
  end
end

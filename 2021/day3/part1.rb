module Day3
  class Part1

    def solve(input)
      report_lines = input.split("\n")

      gamma_rate = ""
      epsilon_rate = ""
      i = 0
      while i < report_lines.first.length
        bits = report_lines.map{|rl| rl[i]}
        dominant_bit = bits.inject(Hash.new(0)) { |h,v| h[v] += 1; h }.max_by(&:last).first
        gamma_rate << dominant_bit
        epsilon_rate << (dominant_bit == "0" ? "1" : "0")
        i += 1
      end

      gamma_rate.to_i(2) * epsilon_rate.to_i(2)
    end
  end
end

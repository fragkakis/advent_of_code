module Day6
  class Part1
    def solve(input)
      ages = input.split(",").map(&:to_i)

      80.times do |i|
        new_lanternfish_count = 0
        new_ages = ages.map do |age|
          case age
          when 0
            new_lanternfish_count += 1
            6
          else
            age - 1
          end
        end
        ages = new_ages + [8] * new_lanternfish_count
      end
      ages.size
    end
  end
end

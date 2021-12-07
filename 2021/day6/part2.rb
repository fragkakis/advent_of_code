module Day6
  class Part2
    def solve(input)
      age_groups = input.split(",").map(&:to_i).tally

      256.times do
        new_age_groups = {}
        age_groups.each do |age, count|
          case age
          when 0
            new_age_groups[6] = (new_age_groups[6] || 0) + count
            new_age_groups[8] = (new_age_groups[8] || 0) + count
          else
            new_age_groups[age - 1] = (new_age_groups[age - 1] || 0) + count
          end
        end
        age_groups = new_age_groups
      end

      age_groups.values.sum
    end
  end
end

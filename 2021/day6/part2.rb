module Day6
  class Part2

    def solve(input)
      ages = input.split(",").map(&:to_i)
      target_days = 256

      remaining_days = target_days % 7
      ages_after_remaining_days = evolve_for_days(ages, remaining_days)
      ages_groups = ages_after_remaining_days.tally

      remaining_weeks = target_days / 7
      puts "Evolving for #{remaining_weeks} weeks"
      remaining_weeks.times do |week_number|
        ages_groups = evolve_one_week(ages_groups)
      end

      ages_groups.values.sum
    end

    def evolve_for_days(ages, days_to_evolve)
      puts "Evolving for #{days_to_evolve} days"
      days_to_evolve.times do |i|
        new_lanternfish_count = 0
        new_ages = ages.map do |age|
          case age
          when 0
            new_lanternfish_count += 1
            6
          else
            age-1
          end
        end
        ages = new_ages + [8] * new_lanternfish_count
      end
      ages
    end

    def evolve_one_week(last_week_groups)
      {
        0 => (last_week_groups[0] || 0) + last_week_groups[7] || 0,
        1 => (last_week_groups[1] || 0) + (last_week_groups[8] || 0),
        2 => (last_week_groups[2] || 0) + (last_week_groups[0] || 0),
        3 => (last_week_groups[3] || 0) + (last_week_groups[1] || 0),
        4 => (last_week_groups[4] || 0) + (last_week_groups[2] || 0),
        5 => (last_week_groups[5] || 0) + (last_week_groups[3] || 0),
        6 => (last_week_groups[6] || 0) + (last_week_groups[4] || 0),
        7 => (last_week_groups[5] || 0),
        8 => (last_week_groups[6] || 0)
    }
    end

  end
end

# frozen_string_literal: true

require 'active_support/all'

module Day14
  class Part2
    def solve(input)
      map = input.split("\n").map(&:chars)
      loops = {map.to_s => 0}

      loop_size = nil
      latest_spin_num = nil
      1_000_000_000.times do |i|
        map = spin(map)
        # puts "Time #{i + 1}"
        # print(map)
        # puts "\n"

        if loops.key?(map.to_s)
          latest_spin_num = i + 1
          loop_size = latest_spin_num - loops[map.to_s]
          puts ">>>>>>> #{latest_spin_num} is the same as #{loops[map.to_s]}, loop_size is #{loop_size}"
          break
        else
          loops[map.to_s] = i + 1
        end
      end

      remaining_spins = (1_000_000_000 - latest_spin_num) % loop_size
      remaining_spins.times do
        map = spin(map)
      end

      map.each_with_index.map do |line, i|
        line.count("O") * (map.size - i)
      end.sum
    end

    def spin(map)
      %w[north west south east].each do |direction|
        map = tilt_to_direction(map, direction)
      end
      map
    end

    def print(map)
      map.each{|line| puts(line.join)}
    end

    def tilt_to_direction(map, direction)
      case direction
      when "north"
        tilt_horizontally_with_step(map.transpose, -1).transpose
      when "west"
        tilt_horizontally_with_step(map, -1)
      when "south"
        tilt_horizontally_with_step(map.transpose, 1).transpose
      when "east"
        tilt_horizontally_with_step(map, 1)
      else
        raise "unknown direction"
      end
    end

    def tilt_horizontally_with_step(map, step)
      map.each do |line|
        if step == -1
          tilt_line_left(line)
        else
          line.reverse!
          tilt_line_left(line)
          line.reverse!
        end
      end
      map
    end

    def tilt_line_left(line)
      loop do
        changed_occured = false
        (0..line.size - 1).each do |position|
          if line[position] == "." && line[position + 1] == "O"

            changed_occured = true
            line[position] = "O"
            line[position + 1] = "."
          end
        end
        break unless changed_occured
      end
    end

  end
end

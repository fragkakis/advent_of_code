require "active_support/all"

module Day5
  class Part2

    attr_reader :lines, :mappings, :seed_ranges

    def solve(input)
      @lines = input.split("\n")
      load_seed_ranges
      load_mappings

      location_mappings = mappings["humidity-to-location"].sort_by(&:destination_range_start)
      location_mappings.each do |mapping|
        mapping.dest_range.each do |location_value|
          seed_value = reverse_map_value("location", location_value)
          puts "#{location_value} --> #{seed_value}"
          if seed_ranges.any?{|sr| sr.include?(seed_value)}
            return location_value
          end
        end
      end
    end

    private

    def load_seed_ranges
      @seed_ranges = []
      @lines.first.gsub("seeds: ", "").split(" ").map(&:to_i).in_groups_of(2) do |seed_group|
        @seed_ranges << (seed_group[0]..(seed_group[0] + seed_group[1] - 1))
      end
      @seed_ranges.sort_by!(&:begin)
    end

    def load_mappings
      @mappings = {}
      current_mapping = nil
      @lines.each_with_index do |line, i|
        next unless i > 1
        next unless line.present?

        if line =~ /([-\w]+)\smap:/
          current_mapping = $1
          mappings[current_mapping] = []
        else
          mappings[current_mapping] << Mapping.new(*line.split(" ").map(&:to_i))
        end
      end
    end

    def reverse_map_value(type, value)
      mapping_key = mappings.keys.find{|key| key.ends_with?(type) }
      mapping = mappings[mapping_key].find{ |m| m.dest_range.include?(value) }
      mapped_value = if mapping.present?
                       increment_from_destination_range_start = value - mapping.destination_range_start
                       mapping.source_range_start + increment_from_destination_range_start
                     else
                       value
                     end
      mapping_target = mapping_key.split("-to-").first

      if mapping_target == "seed"
        mapped_value
      else
        reverse_map_value(mapping_target, mapped_value)
      end
    end
  end

  class Mapping
    attr_reader :destination_range_start, :source_range_start, :range_length, :dest_range, :source_range

    def initialize(destination_range_start, source_range_start, range_length)
      @destination_range_start = destination_range_start
      @source_range_start = source_range_start
      @range_length = range_length
      @dest_range = (destination_range_start..(destination_range_start + range_length - 1))
      @source_range = (source_range_start..(source_range_start + range_length - 1))
    end
  end

end

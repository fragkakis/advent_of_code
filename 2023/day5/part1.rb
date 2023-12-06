require "active_support/all"

module Day5
  class Part1

    attr_reader :lines, :mappings

    def solve(input)
      @lines = input.split("\n")
      @mappings = {}
      load_mappings
      seeds = @lines.first.gsub("seeds: ", "").split(" ").map(&:to_i)
      seeds.map do |seed|
        map_value("seed", seed)
      end.min
    end

    private

    def map_value(type, value)
      mapping_key = mappings.keys.find{|key| key.starts_with?(type) }
      mapping = mappings[mapping_key].find{ |m| m.source_range_start <= value && value <= m.source_range_start + m.range_length - 1 }
      mapped_value = if mapping.present?
                       increment_from_source_range_start = value - mapping.source_range_start
                       mapping.destination_range_start + increment_from_source_range_start
                     else
                       value
      end
      mapping_target = mapping_key.split("-to-").second

      if mapping_target == "location"
        mapped_value
      else
        map_value(mapping_target, mapped_value)
      end
    end

    def load_mappings
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
  end

  class Mapping
    attr_reader :destination_range_start, :source_range_start, :range_length

    def initialize(destination_range_start, source_range_start, range_length)
      @destination_range_start = destination_range_start
      @source_range_start = source_range_start
      @range_length = range_length
    end
  end
end

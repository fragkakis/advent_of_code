# frozen_string_literal: true

require 'active_support/all'

module Day12
  class Part1
    def solve(input)
      records = []
      group_sizes = []
      input.split("\n").each do |l|
        tokens = l.split(" ")
        records << tokens.first
        group_sizes << tokens.second.split(",").map(&:to_i)
      end

      total = 0
      records.each_with_index do |masked_record, i|
        groups = generate_augmented_groups(group_sizes[i])
        arrangements = calculate(masked_record, groups)
        arrangements = arrangements.select{|a| a.count("#") == group_sizes[i].sum}
        # puts arrangements
        total += arrangements.size
        raise if arrangements.any?{|a| a.size != masked_record.size}
      end
      total
    end

    def calculate(masked_record, groups)
      arrangements = []
      if groups.blank?
        return [masked_record]
      end
      first_group = groups[0]

      (0..masked_record.size - first_group.size).each do |starting_i|
        str_to_replace = masked_record.slice(starting_i..starting_i + first_group.size - 1)
        is_last_iteration = str_to_replace.start_with?("#") && str_to_replace.count("#") == first_group.count("#")
        masked_with_replacement = replace_group_in_masked_record(first_group, masked_record, starting_i)
        if masked_with_replacement.present?
          masked_with_replacement_start = masked_with_replacement.slice(..starting_i + first_group.size - 1)
          arrangements += calculate(masked_with_replacement.slice(starting_i+first_group.size..), groups.slice(1..)).map{|sub_arr| masked_with_replacement_start + sub_arr}
        end
        break if is_last_iteration
      end
      arrangements
    end

    def replace_group_in_masked_record(group, masked_record, starting_i)
      return nil if starting_i - 1 >= 0 && masked_record[starting_i - 1] == "#"
      record_with_replacements = masked_record.dup
      group.chars.each_with_index.each do |group_char, i|
        corresponding_masked_record_char = record_with_replacements[starting_i + i]
        return nil unless corresponding_masked_record_char == "?" || corresponding_masked_record_char == group_char

        record_with_replacements[starting_i + i] = group_char
      end
      # replace all ? until them with .
      (0..starting_i).each do |i|
        record_with_replacements[i] = "." if record_with_replacements[i] == "?"
      end
      record_with_replacements
    end

    def generate_augmented_groups(group_sizes)
      group_sizes.each_with_index.map do |group, i|
        if i != group_sizes.size - 1
          "#" * group + "."
        else
          "#" * group
        end
      end
    end

    def match?(masked, arrangement)
      res = arrangement.chars.each_with_index.all? do |n, i|
        masked[i] == n || masked[i] == "?"
      end
      res
    end

  end
end

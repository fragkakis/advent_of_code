# frozen_string_literal: true

require 'active_support/all'

module Day15
  class Part2
    def solve(input)
      boxes = []
      256.times do
        boxes << []
      end
      input.split(",").each do |str|
        str =~ /(\w+)([-=])(\d?)/
        label = $1
        operation = $2
        focal_length = $3
        box_index = hash(label)
        box = boxes[box_index]
        if operation == "-"
          box.reject!{|lens| lens.start_with?("#{label} ")}
        elsif operation == "="
          new_lens = [label, focal_length].join(" ")
          existing_lens = box.find{|lens| lens.start_with?("#{label} ")}
          if existing_lens.present?
            i = box.index(existing_lens)
            box[i] = new_lens
          else
            box << new_lens
          end
        else
          raise "oops"
        end
        puts "After #{str}"
        boxes.select{|b| b.present?}.each_with_index{|b, i| puts "Box #{i}: #{b}"}
      end

      total = 0
      boxes.each_with_index do |b, b_i|
        b.each_with_index do |l, l_i|
          total += (1 + b_i) * (1 + l_i) * l.split(" ").second.to_i
        end
      end
      total
    end

    def hash(str)
      current_value = 0
      str.chars.each do |c|
        current_value += c.bytes.first
        current_value = 17 * current_value
        current_value = current_value % 256
      end
      current_value
    end

  end
end

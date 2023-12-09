# frozen_string_literal: true

require 'active_support/all'

module Day9
  class Part2

    def solve(input)
      sequences = input.split("\n").map{|line| line.split(" ").map(&:to_i)}

      sequences.map{|seq| find_next_number(seq)}.sum
    end

    private

    def find_next_number(seq)
      i = 0
      current_seq = seq
      input_sequences = {i => current_seq}
      loop do
        i += 1
        new_seq = current_seq.each_cons(2).to_a.map{|couple| couple[1] - couple[0]}
        input_sequences[i] = new_seq
        current_seq = new_seq
        break if new_seq.uniq.size == 1 && new_seq[0] == 0
      end

      (input_sequences.size - 1).downto(0).each do |i|
        if i == input_sequences.size - 1
          input_sequences[i].unshift(0)
        else
          input_sequences[i].unshift(input_sequences[i].first - input_sequences[i+1].first)
        end
      end
      input_sequences[0].first
    end

  end
end

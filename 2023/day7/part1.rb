# frozen_string_literal: true

require 'active_support/all'

module Day7
  class Part1
    STRENGTHS = %w[A K Q J T 9 8 7 6 5 4 3 2].reverse.freeze

    def solve(input)
      lines = input.split("\n")
      hands_to_bids = lines.map do |h|
        tokens = h.split(' ')
        [Hand.new(tokens.first.chars), tokens.second.to_i]
      end.to_h

      hands_to_bids.keys(&:first).sort.each_with_index.map do |hand, i|
        hands_to_bids[hand] * (i + 1)
      end.sum
    end
  end

  class Hand
    # include Comparable
    attr_reader :cards

    def initialize(cards)
      @cards = cards
    end

    def <=>(other)
      # order by type
      result = type_order <=> other.type_order
      return result if result != 0

      # same type, check cards
      cards.each_with_index do |card, i|
        other_card = other.cards[i]
        result = ::Day7::Part1::STRENGTHS.index(card) <=> ::Day7::Part1::STRENGTHS.index(other_card)
        return result if result != 0
      end

      0
    end

    def type_order
      if five_of_a_kind?
        7
      elsif four_of_a_kind?
        6
      elsif full_house?
        5
      elsif three_of_a_kind?
        4
      elsif two_pair?
        3
      elsif one_pair?
        2
      else
        1
      end
    end

    def five_of_a_kind?
      cards_tally.values.include?(5)
    end

    def four_of_a_kind?
      cards_tally.values.include?(4)
    end

    def full_house?
      cards_tally.values.include?(3) && cards_tally.values.include?(2)
    end

    def three_of_a_kind?
      cards_tally.values.include?(3) && cards_tally.values.count(2).zero?
    end

    def two_pair?
      cards_tally.values.count(2) == 2
    end

    def one_pair?
      cards_tally.values.count(2) == 1 && cards_tally.values.count(3).zero?
    end

    def cards_tally
      @cards_tally ||= cards.tally
    end
  end
end

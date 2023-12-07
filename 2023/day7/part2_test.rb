require "test/unit"
require_relative "./part2"

module Day7
  class Part2Test < Test::Unit::TestCase
    def test_solve
      input = File.read(File.expand_path("../input.txt", __FILE__))
      assert_equal 6839, Part2.new.solve(input)
    end

    # 2345J 3
    # 2345A 1
    # J345A 2
    # 32T3K 5
    # Q2KJJ 13
    # T3T3J 17
    # KTJJT 34
    # KK677 7
    # T3Q33 11
    # T55J5 29
    # QQQJA 31
    # Q2Q2Q 19
    # 2JJJJ 53
    # 2AAAA 23
    # JJJJ2 41
    # JAAAA 43
    # AAAAJ 59
    # JJJJJ 37
    # AAAAA 61

    def test_foo
      h1 = Day7::Hand.new(%w[3 2 T 3 K])
      h2 = Day7::Hand.new(%w[T 5 5 J 5])
      h3 = Day7::Hand.new(%w[K K 6 7 7])
      h4 = Day7::Hand.new(%w[K T J J T])
      h5 = Day7::Hand.new(%w[Q Q Q J A])
      h6 = Day7::Hand.new(%w[Q J J Q 2])

      refute h1.five_of_a_kind?
      refute h1.four_of_a_kind?
      refute h1.full_house?
      refute h1.three_of_a_kind?
      refute h1.two_pair?
      assert h1.one_pair?

      refute h2.five_of_a_kind?
      assert h2.four_of_a_kind?
      refute h2.full_house?
      refute h2.three_of_a_kind?
      refute h2.two_pair?
      refute h2.one_pair?

      refute h3.five_of_a_kind?
      refute h3.four_of_a_kind?
      refute h3.full_house?
      refute h3.three_of_a_kind?
      assert h3.two_pair?
      refute h3.one_pair?

      refute h4.five_of_a_kind?
      assert h4.four_of_a_kind?
      refute h4.full_house?
      refute h4.three_of_a_kind?
      refute h4.two_pair?
      refute h4.one_pair?

      refute h5.five_of_a_kind?
      assert h5.four_of_a_kind?
      refute h5.full_house?
      refute h5.three_of_a_kind?
      refute h5.two_pair?
      refute h5.one_pair?

      refute h6.five_of_a_kind?
      assert h6.four_of_a_kind?
      refute h6.full_house?
      refute h6.three_of_a_kind?
      refute h6.two_pair?
      refute h6.one_pair?

      hands = [h1, h2, h3, h4, h5]
      assert_equal [h1, h3, h2, h5, h4], hands.sort
    end

    def test_order
      h1 = Day7::Hand.new(%w[J K K K 2])
      h2 = Day7::Hand.new(%w[Q Q Q Q 2])
      assert_equal -1, h1 <=> h2
    end

    def test_full_house
      %w[2233J].each do |str|

        h = hand_from_str(str)

        refute h.five_of_a_kind?
        refute h.four_of_a_kind?
        assert h.full_house?
        refute h.three_of_a_kind?
        refute h.two_pair?
        refute h.one_pair?
      end
    end

    def test_five_of_a_kind
      %w[JJJJJ JJJJ2 JAAAA 2JJJJ JAAAA AAAAA].each do |str|

        h = hand_from_str(str)

        assert h.five_of_a_kind?
        refute h.four_of_a_kind?
        refute h.full_house?
        refute h.three_of_a_kind?
        refute h.two_pair?
        refute h.one_pair?
      end
    end

    private

    def hand_from_str(str)
      Day7::Hand.new(str.chars)
    end
  end
end

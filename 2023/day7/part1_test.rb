require "test/unit"
require_relative "./part1"

module Day7
  class Part1Test < Test::Unit::TestCase
    def test_solve
      input = File.read(File.expand_path("../input.txt", __FILE__))
      assert_equal 6440, Part1.new.solve(input)
    end

    def test_compare_1
      assert_equal 1, Day7::Hand.new(%w[K K 6 7 7]) <=> Day7::Hand.new(%w[K T J J T])
    end

    def test_compare_2
      assert_equal 1, Day7::Hand.new(%w[Q Q Q J A]) <=> Day7::Hand.new(%w[T 5 5 J 5])
    end

    def test_foo
      h1 = Day7::Hand.new(%w[Q Q Q J A])
      h2 = Day7::Hand.new(%w[K K 6 7 7])
      h3 = Day7::Hand.new(%w[K T J J T])
      h4 = Day7::Hand.new(%w[T 5 5 J 5])
      h5 = Day7::Hand.new(%w[3 2 T 3 K])

      refute h1.five_of_a_kind?
      refute h1.four_of_a_kind?
      refute h1.full_house?
      assert h1.three_of_a_kind?
      refute h1.two_pair?
      refute h1.one_pair?

      refute h2.five_of_a_kind?
      refute h2.four_of_a_kind?
      refute h2.full_house?
      refute h2.three_of_a_kind?
      assert h2.two_pair?
      refute h2.one_pair?

      refute h3.five_of_a_kind?
      refute h3.four_of_a_kind?
      refute h3.full_house?
      refute h3.three_of_a_kind?
      assert h3.two_pair?
      refute h3.one_pair?

      refute h4.five_of_a_kind?
      refute h4.four_of_a_kind?
      refute h4.full_house?
      assert h4.three_of_a_kind?
      refute h4.two_pair?
      refute h4.one_pair?

      refute h5.five_of_a_kind?
      refute h5.four_of_a_kind?
      refute h5.full_house?
      refute h5.three_of_a_kind?
      refute h5.two_pair?
      assert h5.one_pair?

      hands = [h1, h2, h3, h4, h5]
      assert_equal [h5, h3, h2, h4, h1], hands.sort
    end
  end
end

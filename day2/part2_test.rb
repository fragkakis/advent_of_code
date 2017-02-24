require 'test/unit'
require './part2'

module Day2
  class Part2Test < Test::Unit::TestCase

    def test_solve
      assert_equal '5DB3', Part2.new.solve('ULL
RRDDD
LURDL
UUUUD')
      input = File.read('./input.txt')
      assert_equal 'C2C28', Part2.new.solve(input)
    end
  end
end
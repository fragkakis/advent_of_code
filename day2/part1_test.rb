require 'test/unit'
require './part1'

module Day2
  class Part1Test < Test::Unit::TestCase

    def test_solve
      assert_equal '1985', Part1.new.solve('ULL
RRDDD
LURDL
UUUUD')
      input = File.read('./input.txt')
      assert_equal '61529', Part1.new.solve(input)
    end
  end
end
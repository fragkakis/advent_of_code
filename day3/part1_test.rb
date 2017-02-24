require 'test/unit'
require './part1'

module Day3
  class Part1Test < Test::Unit::TestCase

    def test_solve
      input = File.read('./input.txt')
      assert_equal 982, Part1.new.solve(input)
    end
  end
end
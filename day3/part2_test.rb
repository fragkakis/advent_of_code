require 'test/unit'
require './part2'

module Day3
  class Part2Test < Test::Unit::TestCase

    def test_solve
      input = File.read('./input.txt')
      assert_equal 1826, Part2.new.solve(input)
    end
  end
end
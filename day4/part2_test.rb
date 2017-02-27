require 'test/unit'
require './part2'

module Day4
  class Part2Test < Test::Unit::TestCase

    def test_solve

      input = File.read('./input.txt')
      assert_equal 548, Part2.new.solve(input)
    end
  end
end
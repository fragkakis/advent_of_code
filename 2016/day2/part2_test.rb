require 'test/unit'
require_relative './part2'

module Day2
  class Part2Test < Test::Unit::TestCase

    def test_solve
      assert_equal '5DB3', Part2.new.solve('ULL
RRDDD
LURDL
UUUUD')
      input = File.read(File.expand_path('../input.txt', __FILE__))
      assert_equal 'C2C28', Part2.new.solve(input)
    end
  end
end

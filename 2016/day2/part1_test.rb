require 'test/unit'
require_relative './part1'

module Day2
  class Part1Test < Test::Unit::TestCase

    def test_solve
      assert_equal '1985', Part1.new.solve('ULL
RRDDD
LURDL
UUUUD')
      input = File.read(File.expand_path('../input.txt', __FILE__))
      assert_equal '61529', Part1.new.solve(input)
    end
  end
end

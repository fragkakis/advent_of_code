require 'test/unit'
require './part1'

module Day5
  class Part1Test < Test::Unit::TestCase

    def test_solve
      assert_equal '18f47a30', Part1.new.solve('abc')
      assert_equal 'f77a0e6e', Part1.new.solve('cxdnnyjw')
    end
  end
end
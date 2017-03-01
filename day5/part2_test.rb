require 'test/unit'
require './part2'

module Day5
  class Part2Test < Test::Unit::TestCase

    def test_solve
      assert_equal '05ace8e3', Part2.new.solve('abc')
      assert_equal '999828ec', Part2.new.solve('cxdnnyjw')
    end
  end
end
require "test/unit"
require_relative "./part1"

module Day1
  class Part1Test < Test::Unit::TestCase
    def test_solve
      assert_equal 5, Part1.new.solve("R2, L3")
      assert_equal 2, Part1.new.solve("R2, R2, R2")
      assert_equal 12, Part1.new.solve("R5, L5, R5, R3")
      input = File.read(File.expand_path("../input.txt", __FILE__))
      assert_equal 298, Part1.new.solve(input)
    end
  end
end

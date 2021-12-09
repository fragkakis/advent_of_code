require "test/unit"
require_relative "./part1"

module Day9
  class Part1Test < Test::Unit::TestCase
    def test_solve
      input = File.read(File.expand_path("../input.txt", __FILE__))
      assert_equal 494, Part1.new.solve(input)
    end
  end
end

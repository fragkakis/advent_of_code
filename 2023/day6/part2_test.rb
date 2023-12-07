require "test/unit"
require_relative "./part2"

module Day6
  class Part2Test < Test::Unit::TestCase
    def test_solve
      input = File.read(File.expand_path("../input.txt", __FILE__))
      assert_equal 71503, Part2.new.solve(input)
    end
  end
end

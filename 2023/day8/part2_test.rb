require "test/unit"
require_relative "./part2"

module Day8
  class Part2Test < Test::Unit::TestCase
    def test_solve
      input = File.read(File.expand_path("../input.txt", __FILE__))
      assert_equal 2, Part2.new.solve(input)
    end
  end
end

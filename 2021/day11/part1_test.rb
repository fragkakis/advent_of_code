require "test/unit"
require_relative "./part1"

class Part1Test < Test::Unit::TestCase
  def test_solve
    input = File.read(File.expand_path("../input.txt", __FILE__))
    assert_equal 1656, Part1.new.solve(input)
  end
end

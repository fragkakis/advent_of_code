require 'test/unit'
require_relative './part1'

module Day4
  class Part1Test < Test::Unit::TestCase

    def test_solve

      assert_equal 123, Part1.new.solve('aaaaa-bbb-z-y-x-123[abxyz]')
      assert_equal 987, Part1.new.solve('a-b-c-d-e-f-g-h-987[abcde]')
      assert_equal 404, Part1.new.solve('not-a-real-room-404[oarel]')
      assert_equal 0, Part1.new.solve('totally-real-room-200[decoy]')
      input = File.read(File.expand_path('../input.txt', __FILE__))
      assert_equal 173787, Part1.new.solve(input)
    end
  end
end

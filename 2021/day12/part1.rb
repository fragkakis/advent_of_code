class Part1

  attr_reader :connections

  def solve(input)
    @connections = Hash.new([])
    input.split("\n").each do |line|
      cave1 = line.split("-")[0]
      cave2 = line.split("-")[1]
      connections[cave1] += [cave2]
      connections[cave2] += [cave1]
    end

    successful_paths = []
    test_cave("start", ["start"], successful_paths)
    successful_paths.size
  end

  def test_cave(cave, path_so_far, successful_paths)
    if cave == "end"
      successful_paths << path_so_far
    else
      connections[cave].each do |connected_cave|
        next if small_cave?(connected_cave) && path_so_far.include?(connected_cave)
        test_cave(connected_cave, path_so_far + [connected_cave], successful_paths)
      end
    end
  end

  def small_cave?(str)
    str.downcase == str
  end
end

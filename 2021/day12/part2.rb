class Part2

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
      connections[cave].reject{ |c| c == "start" }.each do |connected_cave|
        if small_cave?(connected_cave) && path_so_far.include?(connected_cave)
          small_caves_in_path = path_so_far.select { |c| small_cave?(c) && c != "start" }
          next if small_caves_in_path.any? && small_caves_in_path.uniq.size != small_caves_in_path.size # a double visit has occurred
        end
        test_cave(connected_cave, path_so_far + [connected_cave], successful_paths)
      end
    end
  end

  def small_cave?(str)
    str.downcase == str
  end
end

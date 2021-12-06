module Day5
  class Part1

    def solve(input)
      input_lines = input.split("\n")
      vents = []
      input_lines.each do |line|
        vents << line.split(" -> ").map{|coords_str| coords_str.split(",").map(&:to_i)}
      end
      vents

      max_x = vents.map{|v| [v[0][0], v[1][0]]}.flatten.max
      max_y = vents.map{|v| [v[0][1], v[1][1]]}.flatten.max

      diagram = {}
      (0..max_x).each do |x|
        diagram[x] = {} unless diagram.key?(x)
        (0..max_y).each do |y|
          diagram[x][y] = 0
        end
      end

      vents.select { |v| vertical?(v) }.each do |vent|
        x = vent[0][0]
        min_y = [vent[0][1], vent[1][1]].min
        max_y = [vent[0][1], vent[1][1]].max

        (min_y..max_y).each do |y|
          diagram[x][y] += 1
        end
      end

      vents.select { |v| horizontal?(v) }.each do |vent|
        y = vent[0][1]
        min_x = [vent[0][0], vent[1][0]].min
        max_x = [vent[0][0], vent[1][0]].max

        (min_x..max_x).each do |x|
          diagram[x][y] += 1
        end
      end

      diagram.values.map(&:values).flatten.select{|value| value > 1}.size
    end

    def vertical?(vent)
      vent[0][0] == vent[1][0]
    end

    def horizontal?(vent)
      vent[0][1] == vent[1][1]
    end
  end
end

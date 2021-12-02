module Day3
  class Part1

    def solve(input)
      tringles = input.split("\n")
      tringles.inject(0) do |invalid_count, triangle|
        sides = triangle.split(' ').map(&:to_i)
        invalid_count += 1 if valid?(sides)
        invalid_count
      end
     end

    def valid?(sides)
      (sides[0] < sides[1] + sides[2]) && (sides[1] < sides[0] + sides[2]) && (sides[2] < sides[0] + sides[1])
    end
  end
end
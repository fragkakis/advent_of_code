module Day4
  class Part1

    def solve(input)
      rooms = input.split("\n")
      rooms.inject(0) do |sector_sum, room|
        /([\w-]+)-(\d+)\[(\w+)\]/.match(room) do
          sector = $2.to_i
          top_letters = $3
          letters = $1.gsub!('-', '')

          sector_sum += sector if valid?(letters, top_letters)
          sector_sum
        end
      end
    end

    def valid?(letters, top_letters)
      counts = Hash.new 0
      letters.split('').each { |l| counts[l] += 1 }
      top_letters == counts.sort_by { |letter, occurrences| [-occurrences, letter] }.first(5).map { |e| e.first }.join
    end
  end
end
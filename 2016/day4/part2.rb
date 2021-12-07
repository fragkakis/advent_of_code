module Day4
  class Part2
    ALPHABET = ("a".."z").to_a

    def solve(input)
      rooms = input.split("\n")
      north_pole_room = rooms.find { |room| north_pole?(room) }
      _, sector, _ = extract_info(north_pole_room)
      sector
    end

    def north_pole?(room)
      letters, sector, top_letters = extract_info(room)
      return unless valid?(letters, top_letters)
      shifted = shift(letters, sector)
      return true if shifted.include?("north") && shifted.include?("pole")
    end

    def shift(letters, positions)
      letters.chars.map { |l| ALPHABET[(ALPHABET.index(l) + positions) % ALPHABET.size] }.join
    end

    def extract_info(room)
      /([\w-]+)-(\d+)\[(\w+)\]/.match(room) do
        sector = $2.to_i
        top_letters = $3
        letters = $1
        return letters, sector, top_letters
      end
    end

    def valid?(letters, top_letters)
      counts = Hash.new 0
      letters.delete!("-").chars.each { |l| counts[l] += 1 }
      top_letters == counts.sort_by { |letter, occurrences| [-occurrences, letter] }.first(5).map { |e| e.first }.join
    end
  end
end

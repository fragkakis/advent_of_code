module Day4
  class Part2

    def solve(input)
      input_lines = input.split("\n")
      numbers = input_lines.first.split(",").map(&:to_i)

      i = 0
      boards = {}
      while(true)
        break if input_lines[2 + (i*6) + 0].nil?
        board = []
        board << input_lines[2 + (i*6) + 0].strip.gsub(/\s+/, ' ').split(" ").map(&:to_i)
        board << input_lines[2 + (i*6) + 1].strip.gsub(/\s+/, ' ').split(" ").map(&:to_i)
        board << input_lines[2 + (i*6) + 2].strip.gsub(/\s+/, ' ').split(" ").map(&:to_i)
        board << input_lines[2 + (i*6) + 3].strip.gsub(/\s+/, ' ').split(" ").map(&:to_i)
        board << input_lines[2 + (i*6) + 4].strip.gsub(/\s+/, ' ').split(" ").map(&:to_i)
        boards[i] = board
        i += 1
      end

      drawn_numbers = []
      winning_board_ids = []
      numbers.each do |n|
        drawn_numbers << n

        winning_board_ids += boards.keys
                              .select{|id| !winning_board_ids.include?(id)}
                              .select{|id| board_wins?(boards[id], drawn_numbers)}

        break if boards.size == winning_board_ids.size
      end

      last_winning_board = boards[winning_board_ids.last]
      sum_of_unmarked_numbers = last_winning_board.flatten.select{|n| !drawn_numbers.include?(n)}.sum
      sum_of_unmarked_numbers * drawn_numbers.last
    end

    def board_wins?(board, drawn_numbers)
      return true if (0..4).to_a.any?{ |line| board[line].all?{|n| drawn_numbers.include?(n)}}

      return true if (0..4).to_a.any? {|column| (0..4).to_a.all?{|line| drawn_numbers.include?(board[line][column])}}

      false
    end
  end
end

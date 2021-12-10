class Part1

  CLOSING_TO_OPENING = {
     ")" => "(",
     "]" => "[",
     "}" => "{",
     ">" => "<"
  }.freeze

  SCORES = {
    ")" => 3,
    "]" => 57,
    "}" => 1197,
    ">" => 25137
  }

  def solve(input)
    lines = input.split("\n")
    lines.map{|l| score_for_line(l)}.sum
  end

  def score_for_line(l)
    queue = []
    l.chars.each do |c|
      if CLOSING_TO_OPENING.keys.include?(c)
        return SCORES[c] if CLOSING_TO_OPENING[c] != queue.pop
      else
        queue.push(c)
      end
    end
    0 # incomplete line
  end
end

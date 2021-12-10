class Part2

  CLOSING_TO_OPENING = {
    ")" => "(",
    "]" => "[",
    "}" => "{",
    ">" => "<"
  }.freeze

  OPENING_TO_CLOSING = CLOSING_TO_OPENING.invert.freeze

  SCORES = {
    ")" => 1,
    "]" => 2,
    "}" => 3,
    ">" => 4
  }.freeze

  def solve(input)
    lines = input.split("\n")
    sorted_scores = lines.map { |l| score_for_line(l) }.compact.sort
    sorted_scores[sorted_scores.size / 2]
  end

  def score_for_line(l)
    queue = []
    l.chars.each do |c|
      if CLOSING_TO_OPENING.keys.include?(c)
        # invalid
        return nil if CLOSING_TO_OPENING[c] != queue.pop
      else
        queue.push(c)
      end
    end
    return 0 unless queue.any?

    line_score(queue)
  end

  def line_score(queue)
    score = 0
    queue.reverse.each_with_index do |c, i|
      score = 5 * score + SCORES[OPENING_TO_CLOSING[c]]
    end
    score
  end
end

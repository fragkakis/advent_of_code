class Part1

  FOLD_LINE_REGEXP = /fold\salong.*/
  Y_FOLD_LINE_REGEXP = /fold\salong\sy=(\d+)?/
  X_FOLD_LINE_REGEXP = /fold\salong\sx=(\d+)?/

  def solve(input)

    input_lines = input.split("\n")
    coords = input_lines.
      select { |l| l[0] =~ /[0-9]/ }.
      map { |l| l.split(",").map(&:to_i) }

    max_x = coords.map { |c| c[0] }.max
    max_y = coords.map { |c| c[1] }.max

    paper = initialize_blank_paper(max_x, max_y)

    coords.each do |x, y|
      paper[x][y] = true
    end

    first_fold_line = input_lines.find{ |l| l.match?(FOLD_LINE_REGEXP) }
    if Y_FOLD_LINE_REGEXP.match?(first_fold_line)
      y_fold = Y_FOLD_LINE_REGEXP.match(first_fold_line).captures.first.to_i
      paper = fold_on_y(paper, y_fold)
    elsif X_FOLD_LINE_REGEXP.match?(first_fold_line)
      x_fold = X_FOLD_LINE_REGEXP.match(first_fold_line).captures.first.to_i
      paper = fold_on_x(paper, x_fold)
    end

    count_dots(paper)
  end

  def fold_on_x(paper, x_fold)
    original_max_x = paper.size - 1
    original_max_y = paper[0].size - 1
    folded_paper = initialize_blank_paper(x_fold, original_max_y)

    (0..x_fold-1).each do |x|
      mirror_x = original_max_x - x
      (0..original_max_y).each do |y|
        folded_paper[x][y] = paper[x][y] || paper[mirror_x][y]
      end
    end
    folded_paper
  end

  def fold_on_y(paper, y_fold)
    original_max_x = paper.size - 1
    original_max_y = paper[0].size - 1
    folded_paper = initialize_blank_paper(original_max_x, y_fold)

    (0..y_fold-1).each do |y|
      mirror_y = original_max_y - y
      (0..original_max_x).each do |x|
        folded_paper[x][y] = paper[x][y] || paper[x][mirror_y]
      end
    end
    folded_paper
  end

  def initialize_blank_paper(max_x, max_y)
    paper = {}
    (0..max_x).each do |x|
      paper[x] = {} unless paper.key?(x)
      (0..max_y).each do |y|
        paper[x][y] = false
      end
    end
    paper
  end

  def count_dots(paper)
    count = 0
    (0..paper.size-1).each do |x|
      (0..paper[0].size-1).each do |y|
        count += 1 if paper[x][y]
      end
    end
    count
  end

end

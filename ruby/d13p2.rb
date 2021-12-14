require_relative "./d13"
require_relative "./d13p1"

def print_dots(dots)
  min_y, max_y = dots.map { |_, y| y }.minmax
  min_x, max_x = dots.map { |x, _| x }.minmax
  canvas = Array.new(max_y - min_y + 1) { Array.new(max_x - min_x + 1, " ") }
  dots.each { |x, y| canvas[y-min_y][x-min_x] = "#" }
  canvas.each { |line| puts line.join("") }
end

dots, folds = parse(ARGF)
print_dots(folds.reduce(dots, &method(:apply_fold)))

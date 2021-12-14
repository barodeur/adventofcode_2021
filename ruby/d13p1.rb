require_relative "./d13"


def transpose(dots)
  dots.map { |x, y| [y, x] }
end

def apply_fold(dots, (dir, v))
  return transpose(apply_fold(transpose(dots), ["y", v])) if dir == "x"
  dots.map { |x, y| y < v ? [x, y] : [x, 2 * v - y] }.uniq
end

if $0 == __FILE__
  dots, folds = parse(ARGF)
  puts apply_fold(dots, folds[0]).count
end

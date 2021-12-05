require_relative "./d05"
require_relative "./d05p1"

def diagonal_points(((x1, y1), (x2,y2)))
  dx = x2 - x1
  dy = y2 - y1
  if dx.abs == dy.abs
    (dx.positive? ? x1.upto(x2) : x1.downto(x2)).zip(dy.positive? ? y1.upto(y2) : y1.downto(y2))
  else
    []
  end
end

if __FILE__ == $0
  puts count_overlap_points(parse($stdin)) { |line|
    line_points(line)
      .concat(line[0] != line[1] ? diagonal_points(line) : [])
  }
end

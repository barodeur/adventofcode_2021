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
  puts parse($stdin)
    .each_with_object(Hash.new(0)) { |line, h|
      line_points(line)
        .concat(line[0] != line[1] ? diagonal_points(line) : [])
        .each { |p| h[p] += 1 }
    }
    .then { |h| h.select { |_, v| v > 1 }.count }
end

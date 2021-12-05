require_relative "./d05"

def line_points(((x1, y1), (x2, y2)))
  if x1 == x2
    [y1, y2].minmax.then { |min, max| (min..max) }.map { |y| [x1, y] }
  elsif y1 == y2
    [x1, x2].minmax.then { |min, max| (min..max) }.map { |x| [x, y1] }
  else
    []
  end
end

if __FILE__ == $0
  puts parse($stdin)
    .each_with_object(Hash.new(0)) { |line, h|
      line_points(line).each { |p| h[p] += 1 }
    }.
    then { |h| h.select { |_, v| v > 1 }.count }
end

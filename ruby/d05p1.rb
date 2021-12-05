puts $stdin
  .each_line
  .lazy
  .map { |line| line.split("->") }
  .map { |points| points.map { |point| point.split(",").map(&:to_i) } }
  .each_with_object(Hash.new(0)) { |((x1, y1), (x2, y2)), h|
    if x1 == x2
      [y1, y2].minmax.then { |min, max| (min..max) }.each { |y| h[[x1, y]] += 1 }
    elsif y1 == y2
      [x1, x2].minmax.then { |min, max| (min..max) }.each { |x| h[[x, y1]] += 1 }
    end
  }.
  then { |h| h.select { |_, v| v > 1 }.count }

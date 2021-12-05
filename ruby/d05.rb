def parse(io)
  io
    .each_line
    .lazy
    .map { |line| line.split("->") }
    .map { |points| points.map { |point| point.split(",").map(&:to_i) } }
end

def count_overlap_points(lines, &block)
  lines
    .each_with_object(Hash.new(0)) { |line, h|
      block.call(line).each { |p| h[p] += 1 }
    }
    .then { |h| h.select { |_, v| v > 1 }.count }
end

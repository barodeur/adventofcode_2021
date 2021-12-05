def parse(io)
  io
    .each_line
    .lazy
    .map { |line| line.split("->") }
    .map { |points| points.map { |point| point.split(",").map(&:to_i) } }
end

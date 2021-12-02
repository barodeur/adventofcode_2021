def parse(io)
  io
    .each_line
    .lazy
    .map { |line| line.split }
    .map { |direction, val| [direction, val.to_i] }
end

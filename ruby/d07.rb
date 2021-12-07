def parse(io)
  io.read.split(",").map(&:to_i)
end

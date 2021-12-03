def parse(io)
  io
    .each_line
    .lazy
    .map(&:strip)
    .map { |line| line.split("").map(&:to_i) }
end

def bits_to_int(bits)
  bits.join("").to_i(2)
end

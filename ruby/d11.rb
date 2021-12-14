def parse(io)
  io.each_line.map { |l| l.strip.chars.map(&:to_i) }.to_a
end

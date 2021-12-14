def parse(io)
  io.each_line.with_object(Hash.new { |h, k| h[k] = [] }) do |line, obj|
    nodes = line.strip.split("-")
    obj[nodes[0]].push(nodes[1])
    obj[nodes[1]].push(nodes[0])
  end
end

def is_small_cave?(cave)
  cave == cave.downcase
end

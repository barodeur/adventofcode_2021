def parse(io)
  io.each_line.map { |l| l.strip.split("").map(&:to_i) }.to_a
end

def neightboors(heatmap, (i, j))
  n = heatmap.size - 1
  m = heatmap[0].size - 1
  [[-1, 0], [0, 1], [1, 0], [0, -1]]
    .map { |di, dj| [i + di, j + dj] }
    .select { |(ni, nj)| ni.between?(0, n) && nj.between?(0, m) }
end

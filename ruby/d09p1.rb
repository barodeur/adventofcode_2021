def lows(heatmap)
  heatmap.flat_map.with_index do |row, i|
    row.filter_map.with_index do |v, j|
      n_coords = [[i-1, j], [i, j+1], [i+1, j], [i, j-1]]
      n_values = n_coords
        .select { |(ni, nj)| ni.between?(0, heatmap.size-1) && nj.between?(0, heatmap[0].size-1) }
        .map { |(ni, nj)| heatmap[ni][nj] }
      n_values.all? { |nv| nv > v } ? v : nil
    end
  end
end

hm = $stdin.each_line.map { |l| l.strip.split("").map(&:to_i) }.to_a
pp lows(hm).sum { |v| v + 1 }

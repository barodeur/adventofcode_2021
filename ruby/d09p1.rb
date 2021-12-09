require_relative "./d09"

def lows(heatmap)
  heatmap.flat_map.with_index do |row, i|
    row.filter_map.with_index do |v, j|
      n_values = neightboors(heatmap, [i, j]).map { |(ni, nj)| heatmap[ni][nj] }
      n_values.all? { |nv| nv > v } ? v : nil
    end
  end
end

if __FILE__ == $0
  puts lows(parse(ARGF)).sum { |v| v + 1 }
end

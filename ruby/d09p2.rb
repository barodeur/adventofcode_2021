require_relative "./d09"

def basin_size(hm, (i, j))
  b = {}
  list = [[i, j]]
  while list.any?
    i, j = list.shift
    v = hm[i][j]
    next if v == 9
    b[[i, j]] = true
    n = neightboors(hm, [i, j]).reject { |(ni, nj)| b[[ni, nj]] }
    list.concat(n)
  end
  b.size
end

def lows(hm)
  hm.flat_map.with_index { |row, i|
    row.filter_map.with_index { |v, j|
      neightboors(hm, [i, j]).all? { |ni, nj| hm[ni][nj] > v } ? [i, j] : nil
    }
  }
end

heatmap = parse(ARGF)
puts lows(heatmap)
  .map { |i, j| basin_size(heatmap, [i, j]) }
  .sort
  .reverse!
  .first(3)
  .reduce(:*)

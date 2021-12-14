require_relative "./d11"

def apply_step!(grid)
  n = grid.length
  m = grid[0].length

  # First, the energy level of each octopus increases by 1.
  for i in 0...n do
    for j in 0...m do
      grid[i][j] += 1
    end
  end

  # Then, any octopus with an energy level greater than 9 flashes.
  # This increases the energy level of all adjacent octopuses by 1,
  # including octopuses that are diagonally adjacent.
  # If this causes an octopus to have an energy level greater than 9,
  # it also flashes. This process continues as long as new octopuses
  # keep having their energy level increased beyond 9. (An octopus can
  # only flash at most once per step.)
  flashed = Array.new(n) { Array.new(m, false) }
  loop do
    flashing_coords = grid.flat_map.with_index { |row, i| row.flat_map.with_index { |e, j| (!flashed[i][j] && e > 9) ? [[i, j]] : [] } }
    break if flashing_coords.empty?
    flashing_coords.each do |i, j|
      [[-1, 0], [-1, 1], [0, 1], [1, 1], [1, 0], [1, -1], [0, -1], [-1, -1]]
        .map { |di, dj| [i + di, j + dj] }
        .select { |ni, nj| ni.between?(0, n - 1) && nj.between?(0, m - 1) }
        .each { |ni, nj| grid[ni][nj] += 1  }
      flashed[i][j] = true
    end
  end

  # Finally, any octopus that flashed during this step has its energy
  # level set to 0, as it used all of its energy to flash.
  for i in 0...n do
    for j in 0...m do
      if flashed[i][j]
        grid[i][j] = 0
      end
    end
  end

  flashed.sum { |row| row.sum { |v| v ? 1 : 0 } }
end

if $0 == __FILE__
  sum = 0
  grid = parse(ARGF)
  100.times do |i|
    sum += apply_step!(grid)
  end

  puts sum
end

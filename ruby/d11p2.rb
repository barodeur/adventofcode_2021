require_relative "./d11"
require_relative "./d11p1"

step = 1
grid = parse(ARGF)
grid_size = grid.length * grid[0].length
while apply_step!(grid) != grid_size
  step += 1
end

puts step

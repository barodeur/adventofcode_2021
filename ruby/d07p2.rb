require_relative "./d07"



positions = parse($stdin)
best = positions.sum / positions.count
puts positions.sum { |n|
  dist = (n - best).abs
  (dist * (dist + 1)) / 2
}

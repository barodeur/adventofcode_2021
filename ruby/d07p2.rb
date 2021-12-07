require_relative "./d07"

$positions = parse($stdin)

def cost(best)
  $positions.sum { |n|
    dist = (n - best).abs
    (dist * (dist + 1)) / 2  
  }
end

min, max = $positions.minmax
puts (min..max).map(&method(:cost)).min

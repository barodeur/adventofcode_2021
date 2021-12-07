require_relative "./d07"

def median(array)
  return nil if array.empty?
  length = array.length
  sorted = array.sort
  ((sorted[(length - 1) / 2] + sorted[length / 2]) / 2.0).to_i
end

positions = parse($stdin)
med = median(positions)
puts positions.sum { |p| (med - p).abs }

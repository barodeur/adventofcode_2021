f = $stdin.read.split(",").map(&:to_i).each_with_object(Array.new(9, 0)) { |i, dist| dist[i] += 1 }
256.times do
  zeroes = f.shift
  f[6] += zeroes
  f.push(zeroes)
end
puts f.sum

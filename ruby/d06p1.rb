f = $stdin.read.split(",").map(&:to_i)
80.times do
  f.each_with_index do |v, i|
    if v > 0
      f[i] = v - 1
    else
      f[i] = 6
      f.push(9)
    end
  end
end
puts f.count

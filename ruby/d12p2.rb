require_relative "./d12"

count = 0

map = parse(ARGF)

incomplete = [["start"]]
while incomplete.any?
  path = incomplete.pop
  last_cave = path.last
  if last_cave == "end"
    count += 1
  else
    path_tally = path.select(&method(:is_small_cave?)).tally
    map[last_cave]
      .select { |n| n != "start" && (!is_small_cave?(n) || path_tally[n].nil? || path_tally.values.none? { |v| v >= 2 }) }
      .each do |n|
        incomplete.push(path + [n])
      end
  end
end

puts count

require_relative "./d12"

count = 0

map = parse(ARGF)

incomplete = [["start"]]
while incomplete.any?
  path = incomplete.pop
  last_cave = path.last
  if last_cave == "end"
    count +=1
  else
    map[last_cave]
      .select { |n| !is_small_cave?(n) || !path.include?(n) }
      .each do |n|
        incomplete.push(path + [n])
      end
  end
end

puts count

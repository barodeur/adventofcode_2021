require_relative "./d02"

puts parse($stdin)
  .reduce([0, 0]) { |pos, (direction, val)|
    case direction
    when "forward" then [pos[0] + val, pos[1]]
    when "down" then [pos[0], pos[1] + val]
    when "up" then [pos[0], pos[1] - val]
    end
  }.reduce(&:*)

require_relative "./d02"

puts parse($stdin)
  .reduce({ aim: 0, hpos: 0, depth: 0 }) { |memo, (direction, val)|
    case direction
    when "down" then { **memo, aim: memo[:aim] + val }
    when "up" then { **memo, aim: memo[:aim] - val }
    when "forward" then { **memo, hpos: memo[:hpos] + val, depth: memo[:depth] + val * memo[:aim] }
    end
  }.
  then { |state| state[:hpos] * state[:depth] }

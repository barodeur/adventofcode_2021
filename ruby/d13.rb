def parse(io)
  dots_str, folds_str = io.read.split("\n\n")
  [
    dots_str.lines.map { |l| l.strip.split(",").map(&:to_i) },
    folds_str.lines.map { |l| l.match(/fold along (x|y)=(\d+)/).captures.then { |dir, val| [dir, val.to_i] } }
  ]
end

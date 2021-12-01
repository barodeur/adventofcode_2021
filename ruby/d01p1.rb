puts $stdin.
  each_line.
  map(&:to_i).
  each_cons(2).
  filter { |a, b| a < b }.
  count

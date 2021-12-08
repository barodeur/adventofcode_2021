#               0  1  2  3  4  5  6  7  8  9
digits_lengh = [6, 2, 5, 5, 4, 5, 6, 3, 7, 6]
unique_lengths = digits_lengh.tally.select { |_, v| v == 1 }.keys

puts $stdin
  .each_line
  .lazy
  .flat_map { |line| line.split("|")[1].split(" ").map(&:strip) }
  .select { |d| unique_lengths.include?(d.length) }
  .count

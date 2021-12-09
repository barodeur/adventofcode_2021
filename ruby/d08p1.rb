require_relative "./d08"

unique_lengths = digits_length.tally.select { |_, v| v == 1 }.keys

puts parse($stdin)
  .flat_map { |line| line[1] }
  .select { |d| unique_lengths.include?(d.length) }
  .count

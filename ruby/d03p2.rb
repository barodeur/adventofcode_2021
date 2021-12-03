require_relative "./d03"

input = $stdin.read

bits_arr = parse(input).to_a
bit_n = 0
while bits_arr.length > 1
  sum_bits = bits_arr.sum { |bits| bits[bit_n] }
  mcb = (2 * sum_bits) >= bits_arr.length ? 1 : 0
  bits_arr = bits_arr.filter { |bits| bits[bit_n] == mcb }
  bit_n += 1
end
o2_gen_rating = bits_to_int(bits_arr[0])

bits_arr = parse(input).to_a
bit_n = 0
while bits_arr.length > 1
  size = bits_arr[0].length
  sum_bits = bits_arr.sum { |bits| bits[bit_n] }
  mcb = (2 * sum_bits) < bits_arr.length ? 1 : 0
  bits_arr = bits_arr.filter { |bits| bits[bit_n] == mcb }
  bit_n += 1
end
co2_scrub_rating = bits_to_int(bits_arr[0])

puts o2_gen_rating * co2_scrub_rating

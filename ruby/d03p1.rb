require_relative "./d03"

def most_common_bits(io)
  memo = parse(io)
    .each_with_object({ size: 0, one_counts: [] }) { |arr, memo|
      memo[:size] += 1
      arr.each.with_index { |bit, i|
        memo[:one_counts][i] ||= 0
        memo[:one_counts][i] += bit
      }
    }
  memo[:one_counts].map { |count| (2 * count) >= memo[:size] ? 1 : 0 }
end

epsilon_rate_bits = most_common_bits($stdin)
gamma_rate_bits = epsilon_rate_bits.map { |bit| 1 - bit }
puts epsilon_rate_bits.join("").to_i(2) * gamma_rate_bits.join("").to_i(2)

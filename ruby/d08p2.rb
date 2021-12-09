require_relative "./d08"

def digits_by_length
  @_digits_by_length ||= digits_length.map.with_index.group_by { |length, d| length }.transform_values { |v| v.map(&:last) }
end

def list_mapping(list)
  "abcdefg".chars
    .permutation
    .map { |perm| "abcdefg".chars.zip(perm).to_h }
    .find { |map|
      t_list = list.map { |code| code.chars.map { |c| map[c] }.sort.join("") }
      t_list.sort == code_by_digit.sort
    }
end

pp parse($stdin)
  .sum { |line|
    mapping = list_mapping(line[0])
    line[1].map { |code| digit_by_code[code.chars.map { |c| mapping[c] }.sort.join("")] }.join("").to_i
  }

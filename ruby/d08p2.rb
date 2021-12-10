require_relative "./d08"

def digits_by_length
  @_digits_by_length ||= digits_length.map.with_index.group_by { |length, d| length }.transform_values { |v| v.map(&:last) }
end

$strategy = "bruteforce"

def find_mapping_bruteforce(codes)
  "abcdefg".chars
    .permutation
    .map { |perm| "abcdefg".chars.zip(perm).to_h }
    .find { |map|
      t_list = codes.map { |code| code.chars.map { |c| map[c] }.sort.join("") }
      t_list.sort == code_by_digit.sort
    }
end

def is_complete_mapping?(mapping)
  mapping.keys.sort == "abcdefg".chars
end

def find_mapping_dynprog_aux(codes, mapping, found, cfound)
  return mapping if found.sort == (0..9).to_a
  return nil if codes.empty?
  head, *tail = codes

  if is_complete_mapping?(mapping)
    d = digit_by_code[head.chars.map { |c| mapping[c] }.sort.join("")]
    if d && !found.include?(d)
      return find_mapping_dynprog_aux(tail, mapping, found + [d], cfound + [head.chars.map { |c| mapping[c] }.sort.join("")])
    else
      return nil
    end
  end

  digits_by_length[head.length]
    .reject { |d| found.include?(d) }
    .map { |d|
      dcode = code_by_digit[d]
      t_chars = head.chars - mapping.keys
      o_chars = dcode.chars - mapping.values
      next nil if t_chars.length != o_chars.length
      t_chars
        .permutation
        .map { |perm| find_mapping_dynprog_aux(tail, perm.zip(o_chars).to_h.merge(mapping), found + [d], cfound + [dcode]) }
        .compact
        .first
    }
    .compact
    .first
end

def find_mapping_dynprog(codes)
  find_mapping_dynprog_aux(codes.sort_by(&:length), {}, [], [])
end

def resolve_line(line)
  mapping = $strategy == "bruteforce" ? find_mapping_bruteforce(line[0]) : find_mapping_dynprog(line[0])
  line[1].map { |code| digit_by_code[code.chars.map { |c| mapping[c] }.sort.join("")] }.join("").to_i
end

puts parse(ARGF).sum(&method(:resolve_line))

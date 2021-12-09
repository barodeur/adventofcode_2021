def parse(io)
  io
    .each_line
    .lazy
    .map { |line| line.split("|").map { |part| part.split(" ").map(&:strip) } }
end

def code_by_digit
  #                    0         1     2        3        4       5        6         7      8          9
  @_code_by_digit ||= ["abcefg", "cf", "acdeg", "acdfg", "bcdf", "abdfg", "abdefg", "acf", "abcdefg", "abcdfg"]
end

def digit_by_code
  @_digit_by_code ||= code_by_digit.map.with_index { |code, idx| [code, idx] }.to_h
end

# pp digit_by_code

def digits_length
  @_digit_length ||= code_by_digit.map(&:length)
end

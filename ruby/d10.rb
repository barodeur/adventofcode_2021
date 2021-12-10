CHAR_SCORE = {
  ")" => 3,
  "]" => 57,
  "}" => 1197,
  ">" => 25137
}
CHARS = {
  "(" => ")",
  "[" => "]",
  "{" => "}",
  "<" => ">"
}

def parse(io)
  ARGF
  .each_line
  .lazy
  .map(&:strip)
  .map(&:chars)
end

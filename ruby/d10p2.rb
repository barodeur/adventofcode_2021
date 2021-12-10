require_relative "./d10"
require_relative "./d10p1"

STACK_CHAR_SCORE = {
  ")" => 1,
  "]" => 2,
  "}" => 3,
  ">" => 4
}

def stack_score(stack)
  stack.reduce(0) { |score, c| (score * 5) + STACK_CHAR_SCORE[c] }
end

def find_middle(arr)
  arr[arr.length / 2]
end

scores = parse(ARGF)
  .map(&method(:error_score))
  .filter_map { |score, stack| score == 0 ? stack : nil }
  .map(&:reverse)
  .map(&method(:stack_score))
  .to_a
  .sort!
puts find_middle(scores)

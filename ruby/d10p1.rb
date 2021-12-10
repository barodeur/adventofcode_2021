require_relative "./d10"

def error_score(chars)
  stack = []
  chars = chars.clone
  while chars.any?
    char = chars.shift
    closing_char = CHARS[char]
    if closing_char
      stack.push(closing_char)
    else
      stack_c = stack.pop
      return [CHAR_SCORE[char], stack] if stack_c != char
    end
  end
  return [0, stack]
end

if __FILE__ == $0
  puts parse(ARGF)
    .map(&method(:error_score))
    .map(&:first)
    .sum
end

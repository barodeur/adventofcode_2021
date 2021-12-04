require_relative "./d04"

def solve(drawn_numbers, boards)
  drawn_numbers.each do |n|
    boards.each do |board|
      mark_board!(board, n)
      if is_complete_board?(board)
        return not_found_numbers_from_board(board).sum * n
      end
    end
  end
  throw "No solution found"
end

puts solve(*parse($stdin))

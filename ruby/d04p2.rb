require_relative "./d04"

def solve(drawn_numbers, boards)
  last_completed_board_result = nil
  last_idx = 0
  boards.each do |board|
    drawn_numbers.each_with_index do |n, idx|
      mark_board!(board, n)
      if is_complete_board?(board)
        puts "completed in #{idx} iterations"
        if idx > last_idx
          last_completed_board_result = not_found_numbers_from_board(board).sum * n
          last_idx = idx
        end
        break
      end
    end
  end

  unless last_completed_board_result
    throw "No solution found"
  end

  last_completed_board_result
end

puts solve(*parse($stdin))

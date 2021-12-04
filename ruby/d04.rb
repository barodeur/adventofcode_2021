def parse(io)
  lines = io.each_line.lazy.slice_when { |_, l| l == "\n" }
  drawn_numbers = lines.take(1).force.first.first.split(",").map(&:to_i)
  boards = lines
    .map { |board|
      board.map { |bline|
        bline
          .split(/[ ]+/)
          .map(&:strip)
          .reject(&:empty?)
          .map(&:to_i)
      }
        .reject(&:empty?)
    }
    .map { |board| [board, board.transpose] }
    .map { |board| board.map { |alignment| alignment.map { |row| row.map { |n| [n, false] }.to_h } } }
    .to_a
  [drawn_numbers, boards]
end

def is_complete_board?(board)
  board.each do |alignment|
    alignment.each do |row|
      return true if row.values.all?
    end
  end
  false
end

def not_found_numbers_from_board(board)
  board[0].flat_map { |row| row.select { |_, found| !found }.keys }
end

def mark_board!(board, n)
  board.each do |alignment|
    alignment.each do |row|
      if row.has_key?(n)
        row[n] = true
      end
    end
  end
end

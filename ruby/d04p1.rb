lines = $stdin.each_line.lazy.slice_when { |_, l| l == "\n" }
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

def solve(drawn_numbers, boards)
  drawn_numbers.each do |n|
    boards.each do |board|
      board.each do |alignment|
        alignment.each do |row|
          if row.has_key?(n)
            row[n] = true
            if row.values.all?
              not_found = alignment.flat_map { |row| row.select { |_, found| !found }.keys }
              return not_found.sum * n 
            end
          end
        end
      end
    end
  end
end

puts solve(drawn_numbers, boards)

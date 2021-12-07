use std::collections::HashSet;

struct Board([[usize; 5]; 5]);
type Called<'a> = HashSet<usize>;

impl Board {
    fn transposed(&self) -> Self {
        let mut t = [[0; 5]; 5];
        for i in 0..5 {
            for j in 0..5 {
                t[i][j] = self.0[j][i];
            }
        }
        Board(t)
    }

    fn has_row_complete(&self, called: &Called) -> bool {
        self.0
            .iter()
            .any(|row| row.iter().all(|i| called.contains(i)))
    }

    fn is_complete(&self, called: &Called) -> bool {
        self.has_row_complete(called) || self.transposed().has_row_complete(called)
    }

    fn not_found_sum(&self, called: &Called) -> usize {
        self.0
            .into_iter()
            .map(|row| {
                row.into_iter()
                    .filter(|i| !called.contains(i))
                    .sum::<usize>()
            })
            .sum()
    }
}

fn parse<I: Iterator<Item = String>>(mut lines: I) -> (Vec<usize>, Vec<Board>) {
    let drawn_numbers = lines
        .next()
        .unwrap()
        .split(',')
        .map(|a| a.parse::<usize>().unwrap())
        .collect::<Vec<_>>();
    lines.next();
    let mut boards = vec![];
    let mut board = [[0 as usize; 5]; 5];
    let mut i = 0;
    while let Some(line) = lines.next() {
        if line.is_empty() {
            boards.push(Board(board));
            board = [[0 as usize; 5]; 5];
            i = 0;
            continue;
        } else {
            let line: [usize; 5] = line
                .split_whitespace()
                .map(|str| str.parse::<usize>().unwrap())
                .collect::<Vec<_>>()
                .try_into()
                .unwrap();
            board[i] = line;
            i += 1;
        }
    }
    boards.push(Board(board));
    (drawn_numbers, boards)
}

pub fn p1<I: Iterator<Item = String>>(lines: I) -> usize {
    let (numbers, boards) = parse(lines);
    let mut called = HashSet::new();
    for n in numbers.iter() {
        for board in boards.iter() {
            called.insert(*n);
            if board.is_complete(&called) {
                return board.not_found_sum(&called) * n;
            }
        }
    }
    panic!("No solution found")
}

pub fn p2<I: Iterator<Item = String>>(lines: I) -> usize {
    let (numbers, boards) = parse(lines);
    let mut last_completed_board = None;
    let mut last_idx = 0;
    let mut called = HashSet::new();
    for board in boards.iter() {
        for (idx, n) in numbers.iter().enumerate() {
            called.insert(*n);
            if board.is_complete(&called) {
                if idx > last_idx {
                    last_completed_board = Some((board, n));
                    last_idx = idx;
                }
                break;
            }
        }
    }

    if let Some((board, n)) = last_completed_board {
        return board.not_found_sum(&called) * n;
    }

    panic!("No solution found")
}

#[cfg(test)]
mod tests {
    use super::{p1, p2};

    fn test_input() -> impl Iterator<Item = String> {
        "7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

22 13 17 11  0
 8  2 23  4 24
21  9 14 16  7
 6 10  3 18  5
 1 12 20 15 19

 3 15  0  2 22
 9 18 13 17  5
19  8  7 25 23
20 11 10 24  4
14 21 16 12  6

14 21 17 24  4
10 16 15  9 19
18  8 23 26 20
22 11 13  6  5
 2  0 12  3  7"
            .lines()
            .map(String::from)
    }
    mod p1 {
        use super::{p1, test_input};

        #[test]
        fn it_works() {
            assert_eq!(p1(test_input()), 4512)
        }
    }

    mod p2 {
        use super::{p2, test_input};

        #[test]
        fn it_works() {
            assert_eq!(p2(test_input()), 1924)
        }
    }
}

use std::io::{self, BufRead};

mod d01;

fn main() {
    let stdin = io::stdin();
    let lines = stdin.lock().lines();
    let res = d01::count_increases(lines);
    println!("{}", res);
}

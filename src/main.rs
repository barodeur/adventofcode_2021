use std::{
    env,
    io::{self, BufRead},
};

mod d01;

fn main() {
    let args: Vec<String> = env::args().collect();
    let stdin = io::stdin();
    let lines = stdin.lock().lines();
    let mut res = None;

    match args.get(1).map(String::as_str).unwrap() {
        "d01p1" => res = Some(d01::count_increases(lines)),
        _ => {}
    }
    println!("{}", res.unwrap());
}

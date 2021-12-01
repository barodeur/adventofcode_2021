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
        "d01p1" => res = Some(d01::p1(lines)),
        "d01p2" => res = Some(d01::p2(lines)),
        _ => {}
    }
    println!("{}", res.unwrap());
}

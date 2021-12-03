use std::{
    env,
    io::{self, BufRead},
};

mod d01;
mod d02;
mod d03;

fn main() {
    let args: Vec<String> = env::args().collect();
    let stdin = io::stdin();
    let lines = stdin.lock().lines().filter_map(Result::ok);
    let mut res = None;

    match args.get(1).map(String::as_str).unwrap() {
        "d01p1" => res = Some(d01::p1(lines)),
        "d01p2" => res = Some(d01::p2(lines)),
        "d02p1" => res = Some(d02::p1(lines)),
        "d02p2" => res = Some(d02::p2(lines)),
        "d03p1" => res = Some(d03::p1(lines)),
        "d03p2" => res = Some(d03::p2(lines)),
        _ => {}
    }
    println!("{}", res.unwrap());
}

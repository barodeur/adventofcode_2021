use std::{
    env,
    io::{self, BufRead},
};

mod d01;
mod d02;
mod d03;
mod d04;
mod d05;
mod d06;
mod d07;

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
        "d04p1" => res = Some(d04::p1(lines)),
        "d04p2" => res = Some(d04::p2(lines)),
        "d05p1" => res = Some(d05::p1(lines)),
        "d05p2" => res = Some(d05::p2(lines)),
        "d06p1" => res = Some(d06::p1(lines)),
        "d06p2" => res = Some(d06::p2(lines)),
        "d07p1" => res = Some(d07::p1(lines)),
        "d07p2" => res = Some(d07::p2(lines)),
        _ => {}
    }
    println!("{}", res.unwrap());
}

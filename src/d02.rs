use std::fmt::Debug;

enum Command {
    Forward(usize),
    Down(usize),
    Up(usize),
}

fn parse_input<I, E>(iter: I) -> impl Iterator<Item = Command>
where
    E: Debug,
    I: Iterator<Item = Result<String, E>>,
{
    iter.filter_map(|line| {
        let l = line.unwrap();
        let parts = l.split_whitespace().collect::<Vec<_>>();
        match (
            parts.get(0),
            parts.get(1).and_then(|v| v.parse::<usize>().ok()),
        ) {
            (Some(&"forward"), Some(val)) => Some(Command::Forward(val)),
            (Some(&"down"), Some(val)) => Some(Command::Down(val)),
            (Some(&"up"), Some(val)) => Some(Command::Up(val)),
            _ => None,
        }
    })
}

pub fn p1<I, E>(iter: I) -> usize
where
    E: Debug,
    I: Iterator<Item = Result<String, E>>,
{
    let mut hpos = 0;
    let mut depth = 0;
    for command in parse_input(iter) {
        match command {
            Command::Forward(val) => hpos += val as isize,
            Command::Down(val) => depth += val as isize,
            Command::Up(val) => depth -= val as isize,
        }
    }
    hpos as usize * depth as usize
}

pub fn p2<I, E>(iter: I) -> usize
where
    E: Debug,
    I: Iterator<Item = Result<String, E>>,
{
    let mut aim = 0;
    let mut hpos = 0;
    let mut depth = 0;
    for command in parse_input(iter) {
        match command {
            Command::Down(val) => aim += val as isize,
            Command::Up(val) => aim -= val as isize,
            Command::Forward(val) => {
                hpos += val as isize;
                depth += val as isize * aim
            }
        }
    }
    hpos as usize * depth as usize
}

#[cfg(test)]
mod tests {
    use super::{p1, p2};
    use std::io;

    fn test_input() -> impl Iterator<Item = Result<String, io::Error>> {
        "forward 5
down 5
forward 8
up 3
down 8
forward 2"
            .lines()
            .map(|l| Ok(String::from(l)))
    }

    mod p1 {
        use super::{p1, test_input};

        #[test]
        fn it_works() {
            assert_eq!(p1(test_input()), 150)
        }
    }

    mod p2 {
        use super::{p2, test_input};

        #[test]
        fn it_works() {
            assert_eq!(p2(test_input()), 900)
        }
    }
}

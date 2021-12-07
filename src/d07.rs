fn parse<I: Iterator<Item = String>>(mut lines: I) -> Vec<usize> {
    lines
        .next()
        .unwrap()
        .split(',')
        .map(|s| s.parse().unwrap())
        .collect::<Vec<_>>()
}

fn median(numbers: &Vec<usize>) -> usize {
    let length = numbers.len();
    let mut sorted = numbers.clone();
    sorted.sort();
    (sorted[(length - 1) / 2] + sorted[length / 2]) / 2
}

fn mean(numbers: &Vec<usize>) -> f64 {
    let length = numbers.len();
    numbers.iter().sum::<usize>() as f64 / length as f64
}

pub fn p1<I: Iterator<Item = String>>(lines: I) -> usize {
    let numbers = parse(lines);
    let med = median(&numbers);
    numbers
        .iter()
        .map(|&n| if n > med { n - med } else { med - n })
        .sum()
}

pub fn p2<I: Iterator<Item = String>>(lines: I) -> usize {
    let numbers = parse(lines);
    let m = mean(&numbers);
    vec![m.ceil() as usize, m.floor() as usize]
        .iter()
        .map(|&candidate| {
            numbers
                .iter()
                .map(|&n| {
                    let dist = if n > candidate {
                        n - candidate
                    } else {
                        candidate - n
                    };
                    (dist * (dist + 1)) / 2
                })
                .sum()
        })
        .min()
        .unwrap()
}

#[cfg(test)]
mod tests {
    use super::{p1, p2};

    fn test_input() -> impl Iterator<Item = String> {
        "16,1,2,0,4,2,7,1,2,14".lines().map(String::from)
    }

    mod p1 {
        use super::{p1, test_input};

        #[test]
        fn it_works() {
            assert_eq!(p1(test_input()), 37)
        }
    }

    mod p2 {
        use super::{p2, test_input};

        #[test]
        fn it_works() {
            assert_eq!(p2(test_input()), 168)
        }
    }
}

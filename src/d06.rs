use std::ptr;

fn iterate<I: Iterator<Item = String>>(mut lines: I, n: usize) -> usize {
    let mut tmp = [0 as usize; 9];
    lines
        .next()
        .unwrap()
        .split(',')
        .map(|s| s.trim().parse::<usize>().unwrap())
        .for_each(|n| tmp[n] += 1);

    for _ in 0..n {
        let zeroes = tmp[0];
        for i in 0..8 {
            unsafe {
                let a: *mut usize = &mut tmp[i];
                let b: *mut usize = &mut tmp[i + 1];
                ptr::swap(a, b);
            }
        }
        tmp[6] += zeroes;
        tmp[8] = zeroes;
    }
    tmp.iter().sum()
}

pub fn p1<I: Iterator<Item = String>>(lines: I) -> usize {
    iterate(lines, 80)
}

pub fn p2<I: Iterator<Item = String>>(lines: I) -> usize {
    iterate(lines, 256)
}

#[cfg(test)]
mod tests {
    use super::{p1, p2};

    fn test_input() -> impl Iterator<Item = String> {
        "3,4,3,1,2".lines().map(String::from)
    }
    mod p1 {
        use super::{p1, test_input};

        #[test]
        fn it_works() {
            assert_eq!(p1(test_input()), 5934)
        }
    }

    mod p2 {
        use super::{p2, test_input};

        #[test]
        fn it_works() {
            assert_eq!(p2(test_input()), 26984457539)
        }
    }
}

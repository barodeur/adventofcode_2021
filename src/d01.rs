use core::fmt::Debug;

pub fn count_increases<I, E>(iter: I) -> usize
where
    E: Debug,
    I: Iterator<Item = Result<String, E>>,
{
    let mut prev = None;
    let mut count = 0;
    for line in iter {
        let n = line.unwrap().parse::<usize>().unwrap();
        prev.map(|p| {
            if n > p {
                count += 1
            }
        });
        prev = Some(n)
    }
    count
}

#[cfg(test)]
mod tests {
    use super::count_increases;
    use std::io;

    #[test]
    fn it_works() {
        let input = "199
200
208
210
200
207
240
269
260
263"
        .lines();
        assert_eq!(
            count_increases::<_, io::Error>(input.map(|l| Ok(String::from(l)))),
            7
        );
    }
}

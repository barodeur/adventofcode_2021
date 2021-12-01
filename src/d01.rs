use core::fmt::Debug;

fn count_increases<I>(iter: I) -> usize
where
    I: Iterator<Item = usize>,
{
    let mut prev = None;
    let mut count = 0;
    for n in iter {
        prev.map(|p| {
            if n > p {
                count += 1
            }
        });
        prev = Some(n)
    }
    count
}

fn parse_input<I, E>(iter: I) -> impl Iterator<Item = usize>
where
    E: Debug,
    I: Iterator<Item = Result<String, E>>,
{
    iter.map(|line| line.unwrap().parse::<usize>().unwrap())
}

pub fn p1<I, E>(iter: I) -> usize
where
    E: Debug,
    I: Iterator<Item = Result<String, E>>,
{
    count_increases(parse_input(iter))
}

#[derive(Debug, Clone)]
pub struct Windows<I, T>
where
    I: Iterator<Item = T>,
{
    iter: I,
    last: Option<(T, T, T)>,
}

impl<I, T> Windows<I, T>
where
    I: Iterator<Item = T>,
{
    fn new(iter: I) -> Self {
        Self { iter, last: None }
    }
}

impl<I, T> Iterator for Windows<I, T>
where
    I: Iterator<Item = T>,
    T: Clone,
{
    type Item = (T, T, T);

    fn next(&mut self) -> Option<Self::Item> {
        let Self { iter, last } = self;

        match last {
            Some((_, b, c)) => {
                let d = iter.next()?;
                let res = Some((b.clone(), c.clone(), d.clone()));
                *last = Some((b.clone(), c.clone(), d.clone()));
                res
            }
            None => match (iter.next(), iter.next(), iter.next()) {
                (Some(a), Some(b), Some(c)) => {
                    *last = Some((a.clone(), b.clone(), c.clone()));
                    Some((a, b, c))
                }
                _ => None,
            },
        }
    }
}

pub fn p2<I, E>(iter: I) -> usize
where
    E: Debug,
    I: Iterator<Item = Result<String, E>>,
{
    count_increases(Windows::new(parse_input(iter)).map(|(a, b, c)| a + b + c))
}

#[cfg(test)]
mod tests {
    fn test_input() -> std::str::Lines<'static> {
        "199
200
208
210
200
207
240
269
260
263"
        .lines()
    }

    mod p1 {
        use super::super::p1;
        use super::test_input;
        use std::io;

        #[test]
        fn it_works() {
            assert_eq!(
                p1::<_, io::Error>(test_input().map(|l| Ok(String::from(l)))),
                7
            );
        }
    }

    mod p2 {
        use super::super::p2;
        use super::test_input;
        use std::io;

        #[test]
        fn it_works() {
            assert_eq!(
                p2::<_, io::Error>(test_input().map(|l| Ok(String::from(l)))),
                5
            );
        }
    }
}

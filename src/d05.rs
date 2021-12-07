use std::{cmp, collections::HashMap};

type Point = (usize, usize);
type Line = (Point, Point);

fn parse<I: Iterator<Item = String>>(lines: I) -> impl Iterator<Item = Line> {
    lines.map(|line| {
        let mut tmp = line.split("->").map(|point| {
            let mut points = point.split(',').map(|n| n.trim().parse::<usize>().unwrap());
            (points.next().unwrap(), points.next().unwrap())
        });
        (tmp.next().unwrap(), tmp.next().unwrap())
    })
}

fn line_points(((x1, y1), (x2, y2)): Line) -> Vec<Point> {
    if x1 == x2 {
        return (cmp::min(y1, y2)..=cmp::max(y1, y2))
            .map(|y| (x1, y))
            .collect();
    } else if y1 == y2 {
        return (cmp::min(x1, x2)..=cmp::max(x1, x2))
            .map(|x| (x, y1))
            .collect();
    }
    vec![]
}

fn diagonal_points(((x1, y1), (x2, y2)): Line) -> Vec<Point> {
    let min_x = cmp::min(x1, x2);
    let max_x = cmp::max(x1, x2);
    let min_y = cmp::min(y1, y2);
    let max_y = cmp::max(y1, y2);

    if (max_x - min_x) == (max_y - min_y) {
        //   (dx.positive? ? x1.upto(x2) : x1.downto(x2)).zip(dy.positive? ? y1.upto(y2) : y1.downto(y2))
        (if min_x == x1 {
            (x1..=x2).collect::<Vec<_>>()
        } else {
            (x2..=x1).rev().collect()
        })
        .into_iter()
        .zip(if min_y == y1 {
            (y1..=y2).collect::<Vec<_>>()
        } else {
            (y2..=y1).rev().collect::<Vec<_>>()
        })
        .collect()
    } else {
        vec![]
    }
}

fn count_overlap_points<I: Iterator<Item = Line>>(
    lines: I,
    line_points: fn(Line) -> Vec<Point>,
) -> usize {
    let mut map = HashMap::new();
    for l in lines {
        for point in line_points(l) {
            map.insert(point, map.get(&point).unwrap_or(&0) + 1 as usize);
        }
    }
    map.values().filter(|&&v| v > 1).count()
}

pub fn p1<I: Iterator<Item = String>>(lines: I) -> usize {
    count_overlap_points(parse(lines), line_points)
}

pub fn p2<I: Iterator<Item = String>>(lines: I) -> usize {
    count_overlap_points(parse(lines), |line| {
        line_points(line)
            .into_iter()
            .chain(
                if line.0 != line.1 {
                    diagonal_points(line)
                } else {
                    vec![]
                }
                .into_iter(),
            )
            .collect()
    })
}

#[cfg(test)]
mod tests {
    use super::{p1, p2};

    fn test_input() -> impl Iterator<Item = String> {
        "0,9 -> 5,9
8,0 -> 0,8
9,4 -> 3,4
2,2 -> 2,1
7,0 -> 7,4
6,4 -> 2,0
0,9 -> 2,9
3,4 -> 1,4
0,0 -> 8,8
5,5 -> 8,2"
            .lines()
            .map(String::from)
    }
    mod p1 {
        use super::{p1, test_input};

        #[test]
        fn it_works() {
            assert_eq!(p1(test_input()), 5)
        }
    }

    mod p2 {
        use super::{p2, test_input};

        #[test]
        fn it_works() {
            assert_eq!(p2(test_input()), 12)
        }
    }
}

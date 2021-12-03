fn parse_lines<I: Iterator<Item = String>>(lines: I) -> impl Iterator<Item = Vec<bool>> {
    lines.map(|line| line.chars().map(|c| c == '1').collect::<Vec<_>>())
}

fn bits_to_usize(vec: &Vec<bool>) -> usize {
    vec.iter()
        .fold(0 as usize, |memo, bit| 2 * memo + if *bit { 1 } else { 0 })
}

pub fn p1<I: Iterator<Item = String>>(lines: I) -> usize {
    let mut bits_arr = parse_lines(lines);
    let first_line = bits_arr.next().unwrap();
    let mut counter = vec![0; first_line.len()];
    let mut size: usize = 0;
    for bits in vec![first_line].into_iter().chain(bits_arr) {
        for (i, bit) in bits.iter().enumerate() {
            let count = counter.get(i).unwrap_or(&0).clone();
            counter[i] = count + (if *bit { 1 } else { 0 });
        }
        size += 1;
    }
    let most_common_bits = counter
        .into_iter()
        .map(|count| 2 * count >= size)
        .collect::<Vec<_>>();
    let least_common_bits = most_common_bits.iter().map(|b| !*b).collect::<Vec<_>>();
    bits_to_usize(&most_common_bits) * bits_to_usize(&least_common_bits)
}

pub fn p2<I: Iterator<Item = String>>(lines: I) -> usize {
    let mut bits_arr = parse_lines(lines);
    let first_line = bits_arr.next().unwrap();
    let input_copy = vec![first_line]
        .into_iter()
        .chain(bits_arr)
        .collect::<Vec<_>>();

    let mut bits_arr = input_copy.clone();
    let mut bit_n = 0;
    while bits_arr.len() > 1 {
        let sum_bits: usize = bits_arr
            .iter()
            .map(|bits| if bits[bit_n] { 1 } else { 0 })
            .sum();
        let mcb = (2 * sum_bits) >= bits_arr.len();
        bits_arr = bits_arr
            .into_iter()
            .filter(|bits| bits[bit_n] == mcb)
            .collect();
        bit_n += 1
    }
    let o2_gen_rating = bits_to_usize(bits_arr.get(0).unwrap());

    bits_arr = input_copy.clone();
    bit_n = 0;
    while bits_arr.len() > 1 {
        let sum_bits: usize = bits_arr
            .iter()
            .map(|bits| if bits[bit_n] { 1 } else { 0 })
            .sum();
        let mcb = (2 * sum_bits) < bits_arr.len();
        bits_arr = bits_arr
            .into_iter()
            .filter(|bits| bits[bit_n] == mcb)
            .collect();
        bit_n += 1
    }
    let co2_scrub_rating = bits_to_usize(bits_arr.get(0).unwrap());

    o2_gen_rating * co2_scrub_rating
}

#[cfg(test)]
mod tests {
    use super::{p1, p2};

    fn test_input() -> impl Iterator<Item = String> {
        "00100
11110
10110
10111
10101
01111
00111
11100
10000
11001
00010
01010"
            .lines()
            .map(String::from)
    }

    mod p1 {
        use super::{p1, test_input};

        #[test]
        fn it_works() {
            assert_eq!(p1(&mut test_input()), 198)
        }
    }

    mod p2 {
        use super::{p2, test_input};

        #[test]
        fn it_works() {
            assert_eq!(p2(&mut test_input()), 230)
        }
    }
}

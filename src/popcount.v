pub fn popcount(n: u8) -> u8 {
  for (i, c): (u8, u8) in u8:0..u8:8 {
    c + ((n >> i) & u8:1)
  }(u8:0)
}

#![test]
fn popcount_test() {
  let _= assert_eq(popcount(u8:0b0000_0000), u8:0);
  let _= assert_eq(popcount(u8:0b0000_0001), u8:1);
  let _= assert_eq(popcount(u8:0b1111_0000), u8:4);
  let _= assert_eq(popcount(u8:0b0101_0101), u8:4);
  let _= assert_eq(popcount(u8:0b1111_1111), u8:8);
  _
}

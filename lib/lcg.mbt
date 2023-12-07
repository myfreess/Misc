// Linear Congruential Generators
// x[n+1] = (x[n] * a + c) % m
// a = 25214903917 = 0x5DEECE66D，c=11，m = 2^48 = 281474976710656

pub fn mkLCGRandom(seed:Int64) -> (() -> Int) {
  // 照着Java的java.util.Random抄的
  var prev = seed.lxor(25214903917L).land(281474976710656L - 1L)
  fn random() {
    let res = prev.lsr(15L).land(0x0000_0000_FFFF_FFFFL).to_int() // extract bits 47..16
    prev = (prev * 25214903917L + 11L).land(281474976710656L - 1L)
    return res
  }
  return random 
}
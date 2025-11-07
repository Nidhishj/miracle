== my_math.h
```cpp
using u64 = uint64_t;
using i64 = int64_t;

u64 mult(u64 a, u64 b, u64 m = MOD) {
  // performs modular multiplication (a*b)%m avoiding overflow
  i64 ret = a * b - m * (u64)(1.L / m * a * b);
  return ret + m * (ret < 0) - m * (ret >= (i64)m);
}

u64 pw(u64 b, u64 e, u64 m = MOD) {
  // performs modular exponentiation (b^e)%m avoiding overflow using the above
  // mult function u can use ur bexp fnc as well
  u64 ret = 1;
  for (; e; b = mult(b, b, m), e >>= 1)
    if (e & 1)
      ret = mult(ret, b, m);
  return ret;
}

bool isPrime(u64 n) {
  // miller rabin primality test for 64 bit integers
  if (n < 2 || n % 6 % 4 != 1)
    return (n | 1) == 3;
  u64 A[] = {2, 325, 9375, 28178, 450775, 9780504, 1795265022},
      s = __builtin_ctzll(n - 1), d = n >> s;
  for (u64 a : A) {
    // note we are reducing a mod n as a might be larger than n so it is correct
    // as per the condn of less than n-1
    u64 p = pw(a % n, d, n), i = s;
    while (p != 1 && p != n - 1 && a % n && i--)
      p = mult(p, p, n);
    if (p != n - 1 && i != s)
      return 0;
  }
  return 1;
}

using ull = u64;
ull pollard(ull n) {
  // pollard's rho algo which is probabilistic but works well in practice this
  // will return a nontrivial factor of n
  ull x = 0, y = 0, t = 30, prd = 2, i = 1, q;
  auto f = [&](ull x) { return mult(x, x, n) + i; };
  while (t++ % 40 || __gcd(prd, n) == 1) {
    if (x == y)
      x = ++i, y = f(x);
    if ((q = mult(prd, max(x, y) - min(x, y), n)))
      prd = q;
    x = f(x), y = f(f(y));
  }
  return __gcd(prd, n);
}
vector<ull> factor(ull n) {
  // returns the prime factorization of n in O(n^0.25) time
  if (n == 1)
    return {};
  if (isPrime(n))
    return {n};
  ull x = pollard(n);
  auto l = factor(x), r = factor(n / x);
  l.insert(l.end(), all(r));
  return l;
}
```
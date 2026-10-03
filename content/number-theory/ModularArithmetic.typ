== ModularArithmetic.h
```cpp
const long long MOD = 1e9 + 7;

long long mod_mul(long long a, long long b, long long mod = MOD) {
  a = a % mod;
  b = b % mod;
  return (((a * b) % mod) + mod) % mod;
}

long long mod_add(long long a, long long b, long long mod = MOD) {
  a = a % mod;
  b = b % mod;
  return (((a + b) % mod) + mod) % mod;
}

long long mod_sub(long long a, long long b, long long mod = MOD) {
  a = a % mod;
  b = b % mod;
  return (((a - b) % mod) + mod) % mod;
}

int modexp(int base, int exp, int mod = MOD) {
  int res = 1;
  base %= mod;
  while (exp > 0) {
    if (exp & 1) res = mod_mul(res, base, mod);
    base = mod_mul(base, base, mod);
    exp >>= 1;
  }
  return res;
}

int inv(int a, int m = MOD) {
  return modexp(a, m - 2, m);
}

long long mod_div(long long a, long long b, long long mod = MOD) {
  return mod_mul(a, inv(b, mod), mod);
}

vi fact(int n, int mod = MOD) {
  vi f(n + 1, 1);
  for (int i = 2; i <= n; i++)
    f[i] = mod_mul(f[i - 1], i, mod);
  return f;
}

vi invfact(int n, int mod = MOD) {
  vi facts = fact(n, mod);
  vi invf(n + 1, 1);
  invf[n] = modexp(facts[n], mod - 2, mod);
  for (int i = n - 1; i >= 0; i--)
    invf[i] = mod_mul(invf[i + 1], i + 1, mod);
  return invf;
}

vector<int> comb_fact, comb_invfact;

void init_comb(int n, int mod = MOD) {
  comb_fact = fact(n, mod);
  comb_invfact = invfact(n, mod);
}

int nCr(int n, int r, int mod = MOD) {
  if (r < 0 || r > n) return 0;
  int res = mod_mul(comb_fact[n], comb_invfact[r], mod);
  return mod_mul(res, comb_invfact[n - r], mod);
}
```
== fft_ntt.h
```cpp
// Number Theoretic Transform (NTT)
// O(N log N) polynomial multiplication.
const int mod = 998244353;
const int root = 3;

int power(int base, int exp) {
    int res = 1;
    base %= mod;
    while (exp > 0) {
        if (exp % 2 == 1) res = (1LL * res * base) % mod;
        base = (1LL * base * base) % mod;
        exp /= 2;
    }
    return res;
}

int modInverse(int n) {
    return power(n, mod - 2);
}

void ntt(vector<int> &a, bool invert) {
    int n = a.size();
    for (int i = 1, j = 0; i < n; i++) {
        int bit = n >> 1;
        for (; j & bit; bit >>= 1) j ^= bit;
        j ^= bit;
        if (i < j) swap(a[i], a[j]);
    }
    for (int len = 2; len <= n; len <<= 1) {
        int wlen = power(root, (mod - 1) / len);
        if (invert) wlen = modInverse(wlen);
        for (int i = 0; i < n; i += len) {
            int w = 1;
            for (int j = 0; j < len / 2; j++) {
                int u = a[i + j], v = (1LL * a[i + j + len / 2] * w) % mod;
                a[i + j] = (u + v < mod ? u + v : u + v - mod);
                a[i + j + len / 2] = (u - v >= 0 ? u - v : u - v + mod);
                w = (1LL * w * wlen) % mod;
            }
        }
    }
    if (invert) {
        int n_inv = modInverse(n);
        for (int &x : a) x = (1LL * x * n_inv) % mod;
    }
}

vector<int> multiply(vector<int> const& a, vector<int> const& b) {
    vector<int> fa(a.begin(), a.end()), fb(b.begin(), b.end());
    int n = 1;
    while (n < a.size() + b.size()) n <<= 1;
    fa.resize(n); fb.resize(n);
    ntt(fa, false); ntt(fb, false);
    for (int i = 0; i < n; i++) fa[i] = (1LL * fa[i] * fb[i]) % mod;
    ntt(fa, true);
    vector<int> res(a.size() + b.size() - 1);
    for (int i = 0; i < res.size(); i++) res[i] = fa[i];
    return res;
}

```
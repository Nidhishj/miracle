== berlekamp_massey.h
```cpp
// Berlekamp-Massey Algorithm O(N^2)
// Finds the shortest linear recurrence for a sequence.
const int MOD = 1e9 + 7;

long long power(long long base, long long exp) {
    long long res = 1;
    base %= MOD;
    while (exp > 0) {
        if (exp % 2 == 1) res = (res * base) % MOD;
        base = (base * base) % MOD;
        exp /= 2;
    }
    return res;
}

vector<long long> berlekamp_massey(const vector<long long>& s) {
    vector<long long> C = {1}, B = {1};
    int L = 0, m = 1;
    long long b = 1;
    for (int i = 0; i < s.size(); ++i) {
        long long d = 0;
        for (int j = 0; j <= L; ++j)
            d = (d + C[j] * s[i - j]) % MOD;
        if (d == 0) {
            ++m;
        } else {
            vector<long long> T = C;
            long long c = (d * power(b, MOD - 2)) % MOD;
            while (C.size() <= B.size() + m) C.push_back(0);
            for (int j = 0; j < B.size(); ++j)
                C[j + m] = (C[j + m] - c * B[j] % MOD + MOD) % MOD;
            if (2 * L <= i) {
                L = i + 1 - L;
                B = T;
                b = d;
                m = 1;
            } else {
                ++m;
            }
        }
    }
    C.erase(C.begin());
    for (long long& x : C) x = (MOD - x) % MOD;
    return C; // C[0]*s[i-1] + C[1]*s[i-2] + ... = s[i]
}

```
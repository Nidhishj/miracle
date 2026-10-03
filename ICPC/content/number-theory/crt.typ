== crt.h
```cpp
pair<long long, long long> crt2(long long a1, long long m1, long long a2, long long m2) {
    long long x, y;
    long long g = ext_gcd(m1, m2, x, y);
    if ((a1 - a2) % g != 0) return {-1, -1};
    long long lcm = (m1 / g) * m2;
    long long res = a1 + (x * (a2 - a1) / g % (m2 / g)) * m1;
    return {(res % lcm + lcm) % lcm, lcm};
}

pair<long long, long long> crt(const vector<long long>& a, const vector<long long>& m) {
    if (a.empty()) return {-1, -1};
    pair<long long, long long> res = {a[0] % m[0], m[0]};
    for (size_t i = 1; i < a.size(); i++) {
        res = crt2(res.first, res.second, a[i] % m[i], m[i]);
        if (res.second == -1) return {-1, -1};
    }
    return res;
}

```
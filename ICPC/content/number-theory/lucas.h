// Assumes fact and invfact are precomputed modulo p
vector<int> fact, invfact;

int nCr_mod_p(int n, int r, int p) {
    if (r < 0 || r > n) return 0;
    long long res = 1LL * fact[n] * invfact[r] % p;
    return 1LL * res * invfact[n - r] % p;
}

int lucas(long long n, long long r, int p) {
    if (r == 0) return 1;
    int ni = n % p, ri = r % p;
    if (ri > ni) return 0; // nCr = 0 if r > n
    return 1LL * lucas(n / p, r / p, p) * nCr_mod_p(ni, ri, p) % p;
}

== linear_sieve.h
```cpp
const int MAXN = 1e7 + 5;
vector<int> primes;
int spf[MAXN], phi[MAXN], mu[MAXN];
bool is_composite[MAXN];

void linear_sieve(int n = MAXN - 1) {
    phi[1] = 1;
    mu[1] = 1;
    for (int i = 2; i <= n; ++i) {
        if (!is_composite[i]) {
            primes.push_back(i);
            spf[i] = i;
            phi[i] = i - 1;
            mu[i] = -1;
        }
        for (int p : primes) {
            if (i * p > n) break;
            is_composite[i * p] = true;
            spf[i * p] = p;
            if (i % p == 0) {
                phi[i * p] = phi[i] * p;
                mu[i * p] = 0;
                break;
            } else {
                phi[i * p] = phi[i] * phi[p];
                mu[i * p] = mu[i] * mu[p];
            }
        }
    }
}

```
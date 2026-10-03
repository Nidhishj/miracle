// Linear Basis (XOR Basis)
const int BITS = 60;
struct Basis {
    long long basis[BITS];
    int sz;
    Basis() {
        memset(basis, 0, sizeof(basis));
        sz = 0;
    }
    bool insert(long long x) {
        for (int i = BITS - 1; i >= 0; i--) {
            if ((x >> i) & 1) {
                if (!basis[i]) {
                    basis[i] = x;
                    sz++;
                    return true;
                }
                x ^= basis[i];
            }
        }
        return false;
    }
    long long get_max() {
        long long res = 0;
        for (int i = BITS - 1; i >= 0; i--) {
            res = max(res, res ^ basis[i]);
        }
        return res;
    }
    bool check(long long x) {
        for (int i = BITS - 1; i >= 0; i--) {
            if ((x >> i) & 1) {
                if (!basis[i]) return false;
                x ^= basis[i];
            }
        }
        return true;
    }
};

// Gaussian Elimination over Reals
const double EPS = 1e-9;
int gauss_real(vector<vector<double>> a, vector<double> &ans) {
    int n = a.size(), m = a[0].size() - 1;
    vector<int> where(m, -1);
    for (int col = 0, row = 0; col < m && row < n; ++col) {
        int sel = row;
        for (int i = row; i < n; ++i)
            if (abs(a[i][col]) > abs(a[sel][col])) sel = i;
        if (abs(a[sel][col]) < EPS) continue;
        swap(a[sel], a[row]);
        where[col] = row;
        for (int i = 0; i < n; ++i) {
            if (i != row) {
                double c = a[i][col] / a[row][col];
                for (int j = col; j <= m; ++j) a[i][j] -= a[row][j] * c;
            }
        }
        ++row;
    }
    ans.assign(m, 0);
    for (int i = 0; i < m; ++i)
        if (where[i] != -1) ans[i] = a[where[i]][m] / a[where[i]][i];
    for (int i = 0; i < n; ++i) {
        double sum = 0;
        for (int j = 0; j < m; ++j) sum += ans[j] * a[i][j];
        if (abs(sum - a[i][m]) > EPS) return 0; // No solution
    }
    for (int i = 0; i < m; ++i) if (where[i] == -1) return -1; // Infinite solutions
    return 1; // Unique solution
}

// Gaussian Elimination mod 2 (Bitwise XOR)
// a is a vector of bitsets, n equations, m variables. The last bit is the constant.
int gauss_xor(vector<bitset<2005>> a, int n, int m, bitset<2005> &ans) {
    vector<int> where(m, -1);
    for (int col = 0, row = 0; col < m && row < n; ++col) {
        for (int i = row; i < n; ++i)
            if (a[i][col]) { swap(a[i], a[row]); break; }
        if (!a[row][col]) continue;
        where[col] = row;
        for (int i = 0; i < n; ++i)
            if (i != row && a[i][col]) a[i] ^= a[row];
        ++row;
    }
    for (int i = 0; i < m; ++i)
        if (where[i] != -1) ans[i] = a[where[i]][m];
    for (int i = 0; i < n; ++i) {
        int sum = 0;
        for (int j = 0; j < m; ++j) sum ^= (ans[j] & a[i][j]);
        if (sum != a[i][m]) return 0; // No solution
    }
    for (int i = 0; i < m; ++i) if (where[i] == -1) return -1; // Infinite solutions
    return 1;
}

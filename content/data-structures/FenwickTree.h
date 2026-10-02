template <typename T>
class FenwickTree {
 public:
  int n;
  vector<T> bit;
  // 1 based fenwick tree, bit[1] = a[1]
  FenwickTree(int size) : n(size), bit(n + 1, T{}) {}

  FenwickTree(const vector<T>& arr) : FenwickTree((int)arr.size() - 1) {
    build(arr);
  }

  void build(const vector<T>& arr) {
    bit.assign(n + 1, T{});
    for (int i = 1; i <= n; ++i) {
      bit[i] += arr[i];
      int parent = i + (i & -i);
      if (parent <= n) bit[parent] += bit[i];
    }
  }

  void update(int idx, T delta) {
    for (; idx <= n; idx += idx & -idx)
      bit[idx] += delta;
  }

  T query(int idx) const {
    T result{};
    for (; idx > 0; idx -= idx & -idx)
      result += bit[idx];
    return result;
  }

  T query(int left, int right) const {
    return query(right) - query(left - 1);
  }
};
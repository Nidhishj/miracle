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

template <typename T>
class FenwickTree2D {
 public:
  int n, m;
  vector<vector<T>> bit;

  // 1 based 2D Fenwick tree. bit[i][j] covers the rectangle ending at
  // (i, j) with dimensions (i & -i) by (j & -j).
  FenwickTree2D(int rows, int columns)
      : n(rows), m(columns), bit(n + 1, vector<T>(m + 1, T{})) {}

  FenwickTree2D(const vector<vector<T>>& arr)
      : FenwickTree2D((int)arr.size() - 1, (int)arr[0].size() - 1) {
    build(arr);
  }
  // how to use ?
  // write in code
  // FenwickTree2D<int>ft(#rows, #columns);
  // ft.build(arr);
  void build(const vector<vector<T>>& arr) {
    bit.assign(n + 1, vector<T>(m + 1, T{}));
    for (int i = 1; i <= n; ++i)
      for (int j = 1; j <= m; ++j)
        update(i, j, arr[i][j]);
  }

  void update(int row, int column, T delta) {
    for (int i = row; i <= n; i += i & -i)
      for (int j = column; j <= m; j += j & -j)
        bit[i][j] += delta;
  }

  T prefix_sum(int row, int column) const {
    T result{};
    for (int i = row; i > 0; i -= i & -i)
      for (int j = column; j > 0; j -= j & -j)
        result += bit[i][j];
    return result;
  }

  T rectangle_sum(int top, int left, int bottom, int right) const {
    return prefix_sum(bottom, right) - prefix_sum(top - 1, right) -
           prefix_sum(bottom, left - 1) + prefix_sum(top - 1, left - 1);
  }
};

template <typename T>
class RangeFenwickTree {
 public:
  int n;
  vector<T> bit1, bit2;

  RangeFenwickTree(int size) : n(size), bit1(n + 1, T{}), bit2(n + 1, T{}) {}

  RangeFenwickTree(const vector<T>& arr) : RangeFenwickTree((int)arr.size() - 1) {
    build(arr);
  }

  void build(const vector<T>& arr) {
    bit1.assign(n + 1, T{});
    bit2.assign(n + 1, T{});
    for (int i = 1; i <= n; ++i)
      range_add(i, i, arr[i]);
  }

  void range_add(int left, int right, T value) {
    add(bit1, left, value);
    add(bit1, right + 1, -value);
    add(bit2, left, value * (left - 1));
    add(bit2, right + 1, -value * right);
  }

  T prefix_sum(int idx) const {
    return value(bit1, idx) * idx - value(bit2, idx);
  }

  T range_sum(int left, int right) const {
    return prefix_sum(right) - prefix_sum(left - 1);
  }

 private:
  void add(vector<T>& bit, int idx, T value) {
    for (; idx <= n; idx += idx & -idx)
      bit[idx] += value;
  }

  T value(const vector<T>& bit, int idx) const {
    T result{};
    for (; idx > 0; idx -= idx & -idx)
      result += bit[idx];
    return result;
  }
};
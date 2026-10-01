== SegTree.h
```cpp
template <typename T>
// Iterative segment tree with inclusive range queries
class segtree {
 public:
  int n;
  vector<T> tree;

  segtree(int size) : n(size), tree(2 * n, identity()) {}

  segtree(const vector<T>& arr) : n((int)arr.size()), tree(2 * n) {
    build(arr);
  }

  void build(const vector<T>& arr) {
    n = (int)arr.size();
    tree.assign(2 * n, identity());
    copy(arr.begin(), arr.end(), tree.begin() + n);
    for (int node = n - 1; node > 0; --node)
      tree[node] = merge(tree[node << 1], tree[node << 1 | 1]);
  }

  void update(int idx, T value) {
    for (tree[idx += n] = value; idx > 1; idx >>= 1)
      tree[idx >> 1] = merge(tree[idx], tree[idx ^ 1]);
  }

  T query(int l, int r) {
    T left_result = identity(), right_result = identity();
    for (l += n, r += n + 1; l < r; l >>= 1, r >>= 1) {
      if (l & 1) left_result = merge(left_result, tree[l++]);
      if (r & 1) right_result = merge(tree[--r], right_result);
    }
    return merge(left_result, right_result);
  }

 private:
  T merge(T a, T b) { return a + b; }  // change to min/max/gcd
  T identity() { return 0; }           // change to the merge identity
};
```
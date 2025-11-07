// Segment Tree using global T, customizable merge & identity
class segtree {
public:
  int n;
  vector<T> tree;

  segtree(int size) : n(size) { tree.resize(4 * n + 1); }

  void build(int node, int start, int end, const vector<T> &arr) {
    if (start == end) {
      tree[node] = arr[start];
    } else {
      int mid = (start + end) / 2;
      build(2 * node + 1, start, mid, arr);
      build(2 * node + 2, mid + 1, end, arr);
      tree[node] = merge(tree[2 * node + 1], tree[2 * node + 2]);
    }
  }

  void update(int node, int start, int end, int idx, T value) {
    if (start == end) {
      tree[node] = value;
    } else {
      int mid = (start + end) / 2;
      if (idx <= mid)
        update(2 * node + 1, start, mid, idx, value);
      else
        update(2 * node + 2, mid + 1, end, idx, value);
      tree[node] = merge(tree[2 * node + 1], tree[2 * node + 2]);
    }
  }

  T query(int node, int start, int end, int l, int r) {
    if (r < start || end < l)
      return identity();
    if (l <= start && end <= r)
      return tree[node];
    int mid = (start + end) / 2;
    return merge(query(2 * node + 1, start, mid, l, r),
                 query(2 * node + 2, mid + 1, end, l, r));
  }

private:
  T merge(T a, T b) {
    return a + b; // change to min/max/gcd as needed
  }
  T identity() {
    return 0; // change to INF, 0LL, 1LL, etc.
  }
};
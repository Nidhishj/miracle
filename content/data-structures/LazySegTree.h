class LazySegTree {
public:
  int n;
  vector<T> tree, lazy;
  // ---- in cases of assignment question jaha pe value change krni like assign
  // val p from [l,r] vector<bool> marked;  // to track pending assignment

  LazySegTree(int size) : n(size) {
    tree.resize(4 * n + 1);
    lazy.resize(4 * n + 1, 0);
    // --- Uncommment when u need that assign val p in l,r vale
    // marked.resize(4 * n + 1, false);
  }

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

  void apply_lazy(int node, int start, int end) {
    if (lazy[node] != 0) {
      tree[node] += (end - start + 1) * lazy[node];
      if (start != end) {
        lazy[2 * node + 1] += lazy[node];
        lazy[2 * node + 2] += lazy[node];
      }
      lazy[node] = 0;
    }
  }

  void update(int node, int start, int end, int l, int r, T value) {
    apply_lazy(node, start, end);
    if (start > end || start > r || end < l)
      return;

    if (start >= l && end <= r) {
      tree[node] += (end - start + 1) * value;
      if (start != end) {
        lazy[2 * node + 1] += value;
        lazy[2 * node + 2] += value;
      }
      return;
    }

    int mid = (start + end) / 2;
    update(2 * node + 1, start, mid, l, r, value);
    update(2 * node + 2, mid + 1, end, l, r, value);
    tree[node] = merge(tree[2 * node + 1], tree[2 * node + 2]);
  }

  T query(int node, int start, int end, int l, int r) {
    apply_lazy(node, start, end);
    if (start > end || start > r || end < l)
      return identity();
    if (start >= l && end <= r)
      return tree[node];

    int mid = (start + end) / 2;
    return merge(query(2 * node + 1, start, mid, l, r),
                 query(2 * node + 2, mid + 1, end, l, r));
  }

  // ==============================================================
  // ============ OPTIONAL MODE: RANGE ASSIGN =====================
  // ============ (assignment vale question jusme purana add nhi krna )
  // ==============
  // ==============================================================

  /*
  void apply_lazy(int node, int start, int end) {
      if (marked[node]) {
          tree[node] = (end - start + 1) * lazy[node];
          if (start != end) {
              lazy[2 * node + 1] = lazy[node];
              lazy[2 * node + 2] = lazy[node];
              marked[2 * node + 1] = marked[2 * node + 2] = true;
          }
          marked[node] = false;
      }
  }

  void update(int node, int start, int end, int l, int r, T value) {
      apply_lazy(node, start, end);
      if (start > end || start > r || end < l) return;

      if (start >= l && end <= r) {
          tree[node] = (end - start + 1) * value;
          if (start != end) {
              lazy[2 * node + 1] = lazy[2 * node + 2] = value;
              marked[2 * node + 1] = marked[2 * node + 2] = true;
          }
          return;
      }

      int mid = (start + end) / 2;
      update(2 * node + 1, start, mid, l, r, value);
      update(2 * node + 2, mid + 1, end, l, r, value);
      tree[node] = merge(tree[2 * node + 1], tree[2 * node + 2]);
  }
  */

private:
  T merge(T a, T b) { return a + b; } // can replace with min/max/gcd
  T identity() { return 0; }          // replace as needed
};
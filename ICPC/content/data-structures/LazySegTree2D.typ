== LazySegTree2D.h
```cpp
template <typename T>
class LazySegTree2D {
 public:
  int n, m;
  vector<vector<T>> tree, lazy;
  // Uncomment these for assignment mode
  // vector<vector<bool>> marked;

  LazySegTree2D(int n_, int m_) : n(n_), m(m_) {
    tree.assign(4 * n, vector<T>(4 * m, 0));
    lazy.assign(4 * n, vector<T>(4 * m, 0));
    // marked.assign(4 * n, vector<bool>(4 * m, false));
  }

  // ======================== BUILD ==========================

  // here note we store vx and vy which are node of the seg tree
  // lx , rx are the range in x direction
  // ly , ry are the range in y direction
  void build_y(int vx, int lx, int rx, int vy, int ly, int ry,
               const vector<vector<T>>& a) {
    if (ly == ry) {
      if (lx == rx)
        tree[vx][vy] = a[lx][ly];
      else
        tree[vx][vy] = merge(tree[vx * 2][vy], tree[vx * 2 + 1][vy]);
    } else {
      int my = (ly + ry) / 2;
      build_y(vx, lx, rx, vy * 2, ly, my, a);
      build_y(vx, lx, rx, vy * 2 + 1, my + 1, ry, a);
      tree[vx][vy] = merge(tree[vx][vy * 2], tree[vx][vy * 2 + 1]);
    }
  }

  void build_x(int vx, int lx, int rx, const vector<vector<T>>& a) {
    if (lx != rx) {
      int mx = (lx + rx) / 2;
      build_x(vx * 2, lx, mx, a);
      build_x(vx * 2 + 1, mx + 1, rx, a);
    }
    build_y(vx, lx, rx, 1, 0, m - 1, a);
  }

  // ====================== LAZY APPLY (ADD MODE) ===================
  void apply_lazy_y(int vx, int vy, int ly, int ry) {
    if (lazy[vx][vy] != 0) {
      tree[vx][vy] += (ry - ly + 1) * lazy[vx][vy];
      if (ly != ry) {
        lazy[vx][vy * 2] += lazy[vx][vy];
        lazy[vx][vy * 2 + 1] += lazy[vx][vy];
      }
      lazy[vx][vy] = 0;
    }
  }

  // ==================== UPDATE IN Y =====================
  void update_y(int vx, int lx, int rx,
                int vy, int ly, int ry,
                int y1, int y2, T val) {
    apply_lazy_y(vx, vy, ly, ry);
    if (ly > ry || ly > y2 || ry < y1) return;

    if (ly >= y1 && ry <= y2) {
      tree[vx][vy] += (ry - ly + 1) * val;
      if (ly != ry) {
        lazy[vx][vy * 2] += val;
        lazy[vx][vy * 2 + 1] += val;
      }
      return;
    }

    int my = (ly + ry) / 2;
    update_y(vx, lx, rx, vy * 2, ly, my, y1, y2, val);
    update_y(vx, lx, rx, vy * 2 + 1, my + 1, ry, y1, y2, val);
    tree[vx][vy] = merge(tree[vx][vy * 2], tree[vx][vy * 2 + 1]);
  }

  // ==================== UPDATE IN X =====================
  void update_x(int vx, int lx, int rx,
                int x1, int x2, int y1, int y2, T val) {
    if (lx > rx || lx > x2 || rx < x1) return;

    if (lx >= x1 && rx <= x2) {
      update_y(vx, lx, rx, 1, 0, m - 1, y1, y2, val);
      return;
    }

    int mx = (lx + rx) / 2;
    update_x(vx * 2, lx, mx, x1, x2, y1, y2, val);
    update_x(vx * 2 + 1, mx + 1, rx, x1, x2, y1, y2, val);

    for (int vy = 1; vy < 4 * m; vy++) {
      tree[vx][vy] = merge(tree[vx * 2][vy], tree[vx * 2 + 1][vy]);
    }
  }

  // ==================== QUERY IN Y =====================
  T query_y(int vx, int vy, int ly, int ry,
            int y1, int y2) {
    apply_lazy_y(vx, vy, ly, ry);
    if (ly > ry || ly > y2 || ry < y1) return identity();
    if (ly >= y1 && ry <= y2) return tree[vx][vy];

    int my = (ly + ry) / 2;
    return merge(
        query_y(vx, vy * 2, ly, my, y1, y2),
        query_y(vx, vy * 2 + 1, my + 1, ry, y1, y2));
  }

  // ==================== QUERY IN X =====================
  T query_x(int vx, int lx, int rx,
            int x1, int x2, int y1, int y2) {
    if (lx > rx || lx > x2 || rx < x1) return identity();
    if (lx >= x1 && rx <= x2)
      return query_y(vx, 1, 0, m - 1, y1, y2);

    int mx = (lx + rx) / 2;
    T q1 = query_x(vx * 2, lx, mx, x1, x2, y1, y2);
    T q2 = query_x(vx * 2 + 1, mx + 1, rx, x1, x2, y1, y2);
    return merge(q1, q2);
  }

 private:
  T merge(T a, T b) { return a + b; }  // can be min/max/gcd
  T identity() { return 0; }           // depends on merge op
};

```
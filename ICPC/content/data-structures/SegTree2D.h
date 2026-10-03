template <typename T>
class SegTree2D {
 public:
  int n, m;
  vector<vector<T>> tree;
  vector<vector<T>> arr;

  SegTree2D(int _n, int _m) : n(_n), m(_m) {
    arr.assign(n, vector<T>(m, 0));
    tree.assign(4 * n, vector<T>(4 * m, 0));
  }

  void build_y(int node_x, int start_x, int end_x, int node_y, int start_y, int end_y) {
    if (start_y == end_y) {
      if (start_x == end_x)
        tree[node_x][node_y] = arr[start_x][start_y];
      else
        tree[node_x][node_y] = merge(
            tree[node_x * 2][node_y],
            tree[node_x * 2 + 1][node_y]);
    } else {
      int mid_y = (start_y + end_y) / 2;
      build_y(node_x, start_x, end_x, node_y * 2, start_y, mid_y);
      build_y(node_x, start_x, end_x, node_y * 2 + 1, mid_y + 1, end_y);
      tree[node_x][node_y] = merge(
          tree[node_x][node_y * 2],
          tree[node_x][node_y * 2 + 1]);
    }
  }

  void build_x(int node_x, int start_x, int end_x) {
    if (start_x != end_x) {
      int mid_x = (start_x + end_x) / 2;
      build_x(node_x * 2, start_x, mid_x);
      build_x(node_x * 2 + 1, mid_x + 1, end_x);
    }
    build_y(node_x, start_x, end_x, 1, 0, m - 1);
  }

  // Query on y-axis for a fixed x-segment
  T query_y(int node_x, int node_y, int start_y, int end_y, int y1, int y2) {
    if (y1 > end_y || y2 < start_y) return identity();
    if (y1 <= start_y && end_y <= y2) return tree[node_x][node_y];
    int mid_y = (start_y + end_y) / 2;
    return merge(
        query_y(node_x, node_y * 2, start_y, mid_y, y1, y2),
        query_y(node_x, node_y * 2 + 1, mid_y + 1, end_y, y1, y2));
  }

  // Query on x-axis
  T query_x(int node_x, int start_x, int end_x, int x1, int x2, int y1, int y2) {
    if (x1 > end_x || x2 < start_x) return identity();
    if (x1 <= start_x && end_x <= x2)
      return query_y(node_x, 1, 0, m - 1, y1, y2);

    int mid_x = (start_x + end_x) / 2;
    return merge(
        query_x(node_x * 2, start_x, mid_x, x1, x2, y1, y2),
        query_x(node_x * 2 + 1, mid_x + 1, end_x, x1, x2, y1, y2));
  }

  // Update on y-axis for fixed x-segment
  void update_y(int node_x, int start_x, int end_x,
                int node_y, int start_y, int end_y,
                int x, int y, T val) {
    if (start_y == end_y) {
      if (start_x == end_x)
        tree[node_x][node_y] = val;
      else
        tree[node_x][node_y] = merge(
            tree[node_x * 2][node_y],
            tree[node_x * 2 + 1][node_y]);
    } else {
      int mid_y = (start_y + end_y) / 2;
      if (y <= mid_y)
        update_y(node_x, start_x, end_x, node_y * 2, start_y, mid_y, x, y, val);
      else
        update_y(node_x, start_x, end_x, node_y * 2 + 1, mid_y + 1, end_y, x, y, val);

      tree[node_x][node_y] = merge(
          tree[node_x][node_y * 2],
          tree[node_x][node_y * 2 + 1]);
    }
  }

  // Update on x-axis
  void update_x(int node_x, int start_x, int end_x, int x, int y, T val) {
    if (start_x != end_x) {
      int mid_x = (start_x + end_x) / 2;
      if (x <= mid_x)
        update_x(node_x * 2, start_x, mid_x, x, y, val);
      else
        update_x(node_x * 2 + 1, mid_x + 1, end_x, x, y, val);
    }
    update_y(node_x, start_x, end_x, 1, 0, m - 1, x, y, val);
  }

 private:
  T merge(T a, T b) { return a + b; }  // use min/max/gcd as needed
  T identity() { return 0; }
};

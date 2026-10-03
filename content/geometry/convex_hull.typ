== convex_hull.h
```cpp
// Convex Hull (Monotone Chain)
template <class T>
vector<Point<T>> convexHull(vector<Point<T>> pts) {
  int n = pts.size(), k = 0;
  if (n <= 2) return pts;
  vector<Point<T>> hull(2 * n);
  sort(pts.begin(), pts.end(), [](const Point<T>& a, const Point<T>& b) {
    return a.x < b.x || (a.x == b.x && a.y < b.y);
  });
  for (int i = 0; i < n; i++) {
    while (k >= 2 && crossProduct(hull[k - 2], hull[k - 1], pts[i]) <= 0) k--;
    hull[k++] = pts[i];
  }
  for (int i = n - 2, t = k + 1; i >= 0; i--) {
    while (k >= t && crossProduct(hull[k - 2], hull[k - 1], pts[i]) <= 0) k--;
    hull[k++] = pts[i];
  }
  hull.resize(k - 1);
  return hull;
}

```
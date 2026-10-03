// Polygon Math: Shoelace, Point in Polygon
template <class T>
double polygonArea(const vector<Point<T>>& p) {
  T res = 0;
  for (int i = 0, n = p.size(); i < n; i++) {
    res += p[i].cross(p[(i + 1) % n]);
  }
  return abs(res) / 2.0;
}

// Ray casting algorithm for Point in Polygon
// Returns true if strictly inside, handles boundary separately
template <class T>
bool pointInPolygon(const vector<Point<T>>& poly, Point<T> p) {
  bool in = false;
  int n = poly.size();
  for (int i = 0, j = n - 1; i < n; j = i++) {
    if (onSegment(poly[i], poly[j], p)) return true;  // Boundary check (optional)
    if (((poly[i].y > p.y) != (poly[j].y > p.y)) &&
        (p.x < (poly[j].x - poly[i].x) * (p.y - poly[i].y) / (double)(poly[j].y - poly[i].y) + poly[i].x))
      in = !in;
  }
  return in;
}

// Line and Segment Intersections
template <class T>
T crossProduct(Point<T> a, Point<T> b, Point<T> c) {
  return (b - a).cross(c - a);
}

// 1 if left, -1 if right, 0 if collinear
template <class T>
int orientation(Point<T> a, Point<T> b, Point<T> c) {
  T cp = crossProduct(a, b, c);
  return (cp > 0) - (cp < 0);
}

// Check if point p is on segment ab
template <class T>
bool onSegment(Point<T> a, Point<T> b, Point<T> p) {
  return orientation(a, b, p) == 0 && p.x >= min(a.x, b.x) && p.x <= max(a.x, b.x) && p.y >= min(a.y, b.y) && p.y <= max(a.y, b.y);
}

// Check if segment ab and cd intersect
template <class T>
bool segmentIntersect(Point<T> a, Point<T> b, Point<T> c, Point<T> d) {
  int o1 = orientation(a, b, c), o2 = orientation(a, b, d);
  int o3 = orientation(c, d, a), o4 = orientation(c, d, b);
  if (o1 != o2 && o3 != o4) return true;
  if (onSegment(a, b, c) || onSegment(a, b, d) || onSegment(c, d, a) || onSegment(c, d, b)) return true;
  return false;
}

constexpr double GEOMETRY_EPS = 1e-9;

// Projection of p onto the infinite line through a and b.
Pd projectionOnLine(Pd a, Pd b, Pd p) {
  Pd ab = b - a;
  double ab2 = ab.dist2();
  if (ab2 < GEOMETRY_EPS) return a;
  return a + ab * ((p - a).dot(ab) / ab2);
}

// Closest point to p on the closed segment [a, b].
Pd closestPointOnSegment(Pd a, Pd b, Pd p) {
  Pd ab = b - a;
  double ab2 = ab.dist2();
  if (ab2 < GEOMETRY_EPS) return a;
  double t = (p - a).dot(ab) / ab2;
  t = max(0.0, min(1.0, t));
  return a + ab * t;
}

double distancePointToLine(Pd a, Pd b, Pd p) {
  Pd ab = b - a;
  double length = ab.dist();
  if (length < GEOMETRY_EPS) return (p - a).dist();
  return abs(ab.cross(p - a)) / length;
}

double distancePointToSegment(Pd a, Pd b, Pd p) {
  return (p - closestPointOnSegment(a, b, p)).dist();
}

// Infinite line intersection. Returns false for parallel or coincident lines.
bool lineIntersection(Pd a, Pd b, Pd c, Pd d, Pd& res) {
  double cp = (b - a).cross(d - c);
  if (abs(cp) < GEOMETRY_EPS) return false;
  double t = (c - a).cross(d - c) / cp;
  res = a + (b - a) * t;
  return true;
}

// Returns the unique intersection point of closed segments [a, b] and [c, d].
// Collinear overlap has no unique point and therefore returns false.
bool segmentIntersectionPoint(Pd a, Pd b, Pd c, Pd d, Pd& res) {
  if (!lineIntersection(a, b, c, d, res)) return false;
  auto inRange = [](double value, double left, double right) {
    return value >= min(left, right) - GEOMETRY_EPS &&
           value <= max(left, right) + GEOMETRY_EPS;
  };
  return inRange(res.x, a.x, b.x) && inRange(res.y, a.y, b.y) &&
         inRange(res.x, c.x, d.x) && inRange(res.y, c.y, d.y);
}

// Length of the overlap of two collinear segments. Returns zero otherwise.
double collinearSegmentIntersectionLength(Pd a, Pd b, Pd c, Pd d) {
  Pd ab = b - a;
  double ab2 = ab.dist2();
  if (ab2 < GEOMETRY_EPS) return 0.0;
  if (abs(ab.cross(c - a)) > GEOMETRY_EPS ||
      abs(ab.cross(d - a)) > GEOMETRY_EPS)
    return 0.0;

  double tc = (c - a).dot(ab) / ab2;
  double td = (d - a).dot(ab) / ab2;
  double left = max(0.0, min(tc, td));
  double right = min(1.0, max(tc, td));
  return max(0.0, right - left) * sqrt(ab2);
}

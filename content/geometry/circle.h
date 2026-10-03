// Circle Geometry: Tangents and Circle Intersections
struct Circle {
  Pd center;
  double radius;

  Circle(Pd center, double radius) : center(center), radius(radius) {}
};

bool pointInCircle(const Circle& circle, Pd p) {
  return (p - circle.center).dist2() <=
         circle.radius * circle.radius + GEOMETRY_EPS;
}

bool pointOnCircle(const Circle& circle, Pd p) {
  return abs((p - circle.center).dist() - circle.radius) <= GEOMETRY_EPS;
}

// Length of either tangent from p to the circle.
// Returns false when p is strictly inside the circle.
bool tangentLength(const Circle& circle, Pd p, double& length) {
  double d2 = (p - circle.center).dist2();
  double r2 = circle.radius * circle.radius;
  if (d2 < r2 - GEOMETRY_EPS) return false;
  length = sqrt(max(0.0, d2 - r2));
  return true;
}

// Tangency points from p to the circle.
// On the circle, both output points are set to p.
// Returns false when p is strictly inside the circle.
bool tangentPoints(const Circle& circle, Pd p, Pd& t1, Pd& t2) {
  Pd v = p - circle.center;
  double d2 = v.dist2();
  double r2 = circle.radius * circle.radius;
  if (d2 < r2 - GEOMETRY_EPS) return false;
  if (d2 < GEOMETRY_EPS) return false;

  double along = r2 / d2;
  double height = circle.radius * sqrt(max(0.0, d2 - r2)) / d2;
  Pd perpendicular(-v.y, v.x);
  t1 = circle.center + v * along + perpendicular * height;
  t2 = circle.center + v * along - perpendicular * height;
  return true;
}

// Intersections of an infinite line and a circle.
// The output has zero, one, or two points and returns whether any exist.
bool circleLineIntersections(const Circle& circle, Pd a, Pd b,
                             vector<Pd>& result) {
  result.clear();
  Pd foot = projectionOnLine(a, b, circle.center);
  double distance = (foot - circle.center).dist();
  if (distance > circle.radius + GEOMETRY_EPS) return false;

  Pd direction = b - a;
  double length = direction.dist();
  if (length < GEOMETRY_EPS) return pointOnCircle(circle, a) &&
                                    (result.push_back(a), true);
  direction = direction / length;
  double offset = sqrt(max(0.0, circle.radius * circle.radius -
                                    distance * distance));
  result.push_back(foot - direction * offset);
  if (offset > GEOMETRY_EPS) result.push_back(foot + direction * offset);
  return true;
}

// Intersections of two circles. Coincident circles have infinitely many
// intersections and return false because there is no finite result list.
bool circleCircleIntersections(const Circle& first, const Circle& second,
                               vector<Pd>& result) {
  result.clear();
  Pd delta = second.center - first.center;
  double distance = delta.dist();
  double r1 = first.radius, r2 = second.radius;

  if (distance < GEOMETRY_EPS) return false;
  if (distance > r1 + r2 + GEOMETRY_EPS) return false;
  if (distance < abs(r1 - r2) - GEOMETRY_EPS) return false;

  double along = (r1 * r1 - r2 * r2 + distance * distance) /
                 (2.0 * distance);
  double height2 = r1 * r1 - along * along;
  if (height2 < -GEOMETRY_EPS) return false;

  Pd base = first.center + delta * (along / distance);
  if (height2 <= GEOMETRY_EPS) {
    result.push_back(base);
    return true;
  }

  double height = sqrt(height2);
  Pd perpendicular(-delta.y / distance, delta.x / distance);
  result.push_back(base + perpendicular * height);
  result.push_back(base - perpendicular * height);
  return true;
}
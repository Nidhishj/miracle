// Geometric Primitives: Point, Cross Product, Dot Product, Rotation
template <class T>
struct Point {
  T x, y;
  Point() : x(0), y(0) {}
  Point(T x, T y) : x(x), y(y) {}
  Point operator+(const Point& p) const { return Point(x + p.x, y + p.y); }
  Point operator-(const Point& p) const { return Point(x - p.x, y - p.y); }
  Point operator*(T c) const { return Point(x * c, y * c); }
  Point operator/(T c) const { return Point(x / c, y / c); }

  T dot(const Point& p) const { return x * p.x + y * p.y; }
  T cross(const Point& p) const { return x * p.y - y * p.x; }
  T dist2() const { return x * x + y * y; }
  double dist() const { return sqrt(dist2()); }

  // Rotate point by angle rad (counter-clockwise)
  Point<double> rotate(double angle) const {
    return Point<double>(
        x * cos(angle) - y * sin(angle),
        x * sin(angle) + y * cos(angle));
  }
};

using P = Point<long long>;
using Pd = Point<double>;

== Geometry

*Points and vectors:*
Treat a point $(x, y)$ as a vector. For points $a$, $b$, and $c$, the vector
from $a$ to $b$ is $b-a$.

*Dot product:*
$ u dot v = u_x v_x + u_y v_y $

The dot product measures how much one vector points in the direction of another.
It is useful for projections and distances along a line.

*Cross product in 2D:*
$ u times v = u_x v_y - u_y v_x $

For a directed line from $a$ to $b$, compute the 2D cross product
`cross(b - a, c - a)`:

- Positive means $c$ is to the left of $a -> b$.
- Negative means $c$ is to the right.
- Zero means the three points are collinear.

The magnitude is twice the area of triangle `abc`. In code this is
`(b - a).cross(c - a)`, or the helper `crossProduct(a, b, c)`.

*Orientation and segment tests:*
`orientation(a, b, c)` returns $1$, $-1$, or $0$ for left, right, or collinear.
`onSegment(a, b, p)` additionally checks the bounding box, so it identifies a
point on the closed segment rather than anywhere on its infinite line.
Two closed segments intersect when their endpoints lie on opposite sides of
each other, including the collinear endpoint cases handled by `onSegment`.

*Projection and closest point:*
For a point $p$ and line through $a$, $b$, the projection parameter is
$ t = ((p-a) dot (b-a)) / ((b-a) dot (b-a)) $
and the projected point is $a + t(b-a)$.

`projectionOnLine` allows any real $t$. For a segment, clamp $t$ to $[0, 1]$;
`closestPointOnSegment` does this. Therefore:

- `distancePointToLine` uses perpendicular distance
  $ |(b_x-a_x)(p_y-a_y) - (b_y-a_y)(p_x-a_x)| / |b-a| $.
- `distancePointToSegment` measures the distance to the closest projected point,
  or to an endpoint when the projection lies outside the segment.

*Line intersection:*
Write the lines as $a + t(b-a)$ and $c + s(d-c)$. Let
`den` be the cross product of $b-a$ and $d-c$.
If `den` is zero, the lines are parallel or coincident. Otherwise,
the parameter $t$ is the cross product of $c-a$ and $d-c$, divided by `den`,
and the intersection is $a + t(b-a)$.
`lineIntersection` returns this point for infinite lines, while
`segmentIntersectionPoint` also checks that the point lies inside both segments.
Collinear overlapping segments do not have one unique intersection point;
`collinearSegmentIntersectionLength` returns the length of their overlap instead.

*Circle geometry:*
A circle is represented by a center $o$ and radius $r$. A point $p$ is inside
or on the circle when $|p-o| <= r$.

For an external point $p$, the tangent triangle is right-angled at the tangent
point. Therefore the length of either tangent is
$ sqrt(|p-o|^2 - r^2) $.
`tangentLength` returns this length and fails when the point is strictly inside.
`tangentPoints` returns the one tangent point when $p$ is on the circle, or the
two tangent points when $p$ is outside.

To intersect a line and a circle, first project the circle center onto the line.
If the distance from the center to the line is greater than $r$, there is no
intersection. Otherwise move from the projection in both line directions by
$ sqrt(r^2 - d^2) $, where $d$ is the distance from the center to the line.
`circleLineIntersections` returns zero, one, or two points.

For two circles with center distance $d$, let
$ x = (r_1^2 - r_2^2 + d^2) / (2d) $.
The common chord is perpendicular to the line of centers, and its half-length is
$ h = sqrt(r_1^2 - x^2) $.
`circleCircleIntersections` returns zero, one, or two points. Coincident circles
have infinitely many intersections, so the function returns false for that case.

*Convex hull note:*
The monotone chain hull repeatedly removes the last point while the cross product
is non-left-turning. Using `<= 0` removes collinear boundary points; use `< 0`
if all collinear boundary points should be retained.
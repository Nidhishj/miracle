== Combinatorics

*Binomial Theorem:*
$ (x+y)^n = sum_(k=0)^n binom(n, k) x^(n-k) y^k $
Expands powers of a binomial.

*Combinations (nCr):*
$ binom(n, r) = (n!) / (r!(n-r)!) $
Number of ways to choose $r$ items from $n$ distinct items without replacement, order does not matter.

*Permutations (nPr):*
$ P(n, r) = (n!) / ((n-r)!) $
Number of ways to arrange $r$ items from $n$ distinct items, order matters.

*Stars and Bars:*
Used to find the number of integer solutions to $x_1 + x_2 + dots + x_n = k$.

- Case $x_i >= 0$ (non-negative integers):
  $ binom(n+k-1, n-1) $ or $ binom(n+k-1, k) $

- Case $x_i >= 1$ (positive integers):
  $ binom(k-1, n-1) $

*Catalan Numbers ($C_n$):*
$ C_n = 1 / (n+1) binom(2n, n) = binom(2n, n) - binom(2n, n+1) $
- Number of valid parenthesis sequences of length $2n$.
- Number of structurally unique binary trees with $n$ nodes is $C_n$.
- Number of rooted ordered trees with $n$ nodes is $C_{n-1}$.

*Derangements:*
Permutations where no element appears in its original position.
- Recurrence: $ D_n = (n-1)(D_{n-1} + D_{n-2}) $ with $D_1 = 0, D_2 = 1$.
- General Formula: $ D_n = n! sum_(i=0)^n ((-1)^i) / (i!) $

*Principle of Inclusion-Exclusion (PIE):*
Used to count the number of elements in the union of overlapping sets.
$ |A union B union C| = |A| + |B| + |C| - |A sect B| - |A sect C| - |B sect C| + |A sect B sect C| $

== Geometry

*Pick's Theorem:*
Finds the area of a polygon whose vertices are all on integer grid points.
$ "Area" = I + B/2 - 1 $
Where $I$ is the number of interior grid points and $B$ is the number of boundary grid points.

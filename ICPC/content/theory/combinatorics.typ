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

*Stirling Numbers:*
- *First kind* $\begin{bmatrix} n \\ k \end{bmatrix}$: Number of ways to arrange $n$ objects into $k$ disjoint cycles. 
  Recurrence: $\begin{bmatrix} n \\ k \end{bmatrix} = (n-1)\begin{bmatrix} n-1 \\ k \end{bmatrix} + \begin{bmatrix} n-1 \\ k-1 \end{bmatrix}$
- *Second kind* $\begin{Bmatrix} n \\ k \end{Bmatrix}$: Number of ways to partition a set of $n$ elements into $k$ non-empty disjoint subsets.
  Recurrence: $\begin{Bmatrix} n \\ k \end{Bmatrix} = k\begin{Bmatrix} n-1 \\ k \end{Bmatrix} + \begin{Bmatrix} n-1 \\ k-1 \end{Bmatrix}$

*Burnside’s Lemma / Pólya Enumeration:*
Counts distinct objects under symmetric rotations/reflections.
$ |X / G| = \frac{1}{|G|} \sum_{g \in G} |X^g| $
Where $|G|$ is the number of symmetries, and $|X^g|$ is the number of configurations fixed by symmetry $g$.

*Möbius Inversion:*
$ g(n) = \sum_{d \mid n} f(d) \iff f(n) = \sum_{d \mid n} \mu(d) g\left(\frac{n}{d}\right) $
$ g(n) = \sum_{n \mid d} f(d) \iff f(n) = \sum_{n \mid d} \mu\left(\frac{d}{n}\right) g(d) $
Useful for GCD/LCM sum queries.

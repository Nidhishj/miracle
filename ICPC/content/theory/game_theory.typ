== Game Theory

*Nim Sum / Bouton's Theorem:*
A standard normal-play game of Nim with pile sizes $x_1, x_2, \dots, x_n$ is a first-player win if and only if the XOR sum of the pile sizes is non-zero:
$ x_1 \oplus x_2 \oplus \dots \oplus x_n \neq 0 $

*Sprague-Grundy Theorem:*
For any impartial game, any state can be mapped to a Grundy value (nim-value).
$ G(x) = \text{MEX}(\{ G(y) \mid y \text{ is a valid move from } x \}) $
The MEX (Minimum Excluded value) is the smallest non-negative integer not in the set.
The Grundy value of a composite game made of independent independent games is the XOR sum of their individual Grundy values:
$ G(x_1, x_2, \dots, x_n) = G(x_1) \oplus G(x_2) \oplus \dots \oplus G(x_n) $

*Misère Nim:*
Normal Nim rules, but the player forced to take the last object loses.
Strategy: Play exactly like normal Nim (try to leave XOR sum = 0) UNTIL all remaining non-empty piles have size exactly 1.
When all remaining piles have size 1, leave an ODD number of piles to your opponent (this is the opposite of normal Nim where you'd leave an even number).

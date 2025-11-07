== template.h
```cpp
#include <bits/stdc++.h>

#define tc                                                                     \
  int t;                                                                       \
  cin >> t;                                                                    \
  while (t--)                                                                  \
    solve();
using namespace std;
#include <ext/pb_ds/assoc_container.hpp>
#include <ext/pb_ds/tree_policy.hpp>
using namespace __gnu_pbds;
template <class T, class U = null_type, class chash = hash<T>>
using hset = gp_hash_table<T, U, chash>;
template <class T, class U = null_type, class cmp = less<T>>
using oset = tree<T, U, cmp, rb_tree_tag, tree_order_statistics_node_update>;
#define MOD 1000000007
#define int long long
#define pa pair<int, int>
#define fr(i, a, b) for (int i = (a); i < (b); i++)
#define fnr(i, a, b) for (int i = (a); i >= (b); i--)
#define vi vector<int>
#define vpi vector<pa>
#define vvi vector<vi>
#define pb push_back
#define all(s) s.begin(), s.end()
#define set_bits                                                               \
  __builtin_popcountll           // tells the number of setbits or number of 1s
#define zero_bef __builtin_clzll // number of leading zeroes
#define sz(a) (int)a.size()
#define print(v)                                                               \
  for (auto printi : v)                                                        \
  cout << printi << ' '
// make a custom tempelate

using T = long long; // Generic type for templates
using ldbl = long double;

void solve() {}

signed main() {
  ios::sync_with_stdio(false);
  cin.tie(NULL);

  return 0;
}
```
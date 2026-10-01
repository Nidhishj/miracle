== PersistentSegTree.h
```cpp
struct Node {
  int val;
  Node *left, *right;
  Node(int v = 0, Node* l = nullptr, Node* r = nullptr)
      : val(v), left(l), right(r) {}
};

struct PersistentSegTree {
  int n;
  vector<Node*> version;  // roots of each version

  PersistentSegTree(int n) : n(n) {
    version.push_back(build(0, n - 1));  // version[0]: initial (all 0)
  }

  Node* build(int l, int r) {
    if (l == r) return new Node(0);
    int m = (l + r) / 2;
    return new Node(0, build(l, m), build(m + 1, r));
  }

  // create new version with arr[idx] += val
  Node* update(Node* prev, int l, int r, int idx, int val) {
    if (l == r)
      return new Node(prev->val + val);  // create new leaf node

    int m = (l + r) / 2;
    if (idx <= m)
      return new Node(prev->val + val,
                      update(prev->left, l, m, idx, val),
                      prev->right);
    else
      return new Node(prev->val + val,
                      prev->left,
                      update(prev->right, m + 1, r, idx, val));
  }

  int query(Node* node, int l, int r, int ql, int qr) {
    if (!node || ql > r || qr < l) return 0;
    if (ql <= l && r <= qr) return node->val;
    int m = (l + r) / 2;
    return query(node->left, l, m, ql, qr) +
           query(node->right, m + 1, r, ql, qr);
  }

  // user interface:
  void update_version(int prev_version, int idx, int val) {
    Node* new_root = update(version[prev_version], 0, n - 1, idx, val);
    version.push_back(new_root);
  }

  int query_version(int ver, int l, int r) {
    return query(version[ver], 0, n - 1, l, r);
  }
};

```
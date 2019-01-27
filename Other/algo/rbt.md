### Invariants:
* Root node black
* Leaves are black EMPTY node,i.e., no data
* every red node's two children are black
* From node to all leaves, same # of black nodes

### Discussion

* the path from the root to the farthest leaf is no more than twice as long as the path from the root to the nearest leaf.
* A red–black tree is similar in structure to a B-tree of order[note 1] 4, where each node can contain between 1 and 3 values and (accordingly) between 2 and 4 child pointers. In such a B-tree, each node will contain only one value matching the value in a black node of the red–black tree, with an optional value before and/or after it in the same node, both matching an equivalent red node of the red–black tree.
* AVL trees can be colored red-black, thus are a subset of RB trees.
* For every 2-4 tree, there are corresponding red–black trees with data elements in the same order. The insertion and deletion operations on 2-4 trees are also equivalent to color-flipping and rotations in red–black trees. This makes 2-4 trees an important tool for understanding the logic behind red–black trees, and this is why many introductory algorithm texts introduce 2-4 trees just before red–black trees, even though 2-4 trees are not often used in practice.

* rotate left: current becomes RC's LC, RC's LC becomes current's RC, current RC takes the place 

### Insertion
* The big difference is that in the binary search tree a new node is added as a leaf, whereas leaves contain no information in the red–black tree, so instead the new (RED) node replaces an existing leaf and then has two black leaves of its own added.
* Case 1: N is the root node, first node of red–black tree
* Case 2: N's parent (P) is black
* Case 3: P is red (so it can't be the root of the tree) and N's uncle (U) is red
```c
void insert_case3(struct node* n)
{
 parent(n)->color = BLACK;
 uncle(n)->color = BLACK;
 grandparent(n)->color = RED;
 insert_repair_tree(grandparent(n));
}
```
* Case 4: P is red (so it can't be the root of the tree) and N's uncle (U) is black (or does not exist)
 * need to rotate current node into grandparent position
```
void insert_case4(struct node* n)
{
 struct node* p = parent(n);
 struct node* g = grandparent(n);

//move the current node to the outside if applicable
 if (n == g->left->right) {
  rotate_left(p);
  n = n->left;
 } else if (n == g->right->left) {
  rotate_right(p);
  n = n->right; 
 }

 insert_case4step2(n);

}

void insert_case4step2(struct node* n)
{
 struct node* p = parent(n);
 struct node* g = grandparent(n);

 if (n == p->left)
  rotate_right(g);
 else
  rotate_left(g);
 p->color = BLACK;
 g->color = RED;
}
```

* If new node is left to the grandparent, then find the right child of GP, if such node is red, and then set its parent to black, set that node to black, and send to direclty to grandpa node
* If new node is right to the parent, send parent to black, GP to red

### Removal

* In a regular binary search tree when deleting a node with two non-leaf children, we find either the maximum element in its left subtree (which is the in-order predecessor) or the minimum element in its right subtree (which is the in-order successor) and move its value into the node being deleted. We then delete the node we copied the value from, which must have fewer than two non-leaf children.
* If M is a red node, we simply replace it with its child C
* When M is black and C is red. but if we repaint C black, both of these properties are preserved. Additional SIX cases to consider

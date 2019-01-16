### Invariants:
* Root node black
* Leaves are black EMPTY node,i.e., no data
* every red node's two children are black
* From node to all leaves, same # of black nodes

### Insertion

* Find the node without child, and insert into correspoidning node, and then fix the invariants
* Send new node to red, if new node is not root and new node's parent is red - need to fix it
* If new node is left to the grandparent, then find the right child of GP, if such node is red, and then set its parent to black, set that node to black, and send to direclty to grandpa node
* If new node is right to the parent, send parent to black, GP to red

### Example 

[1, 10, 9,2,3,8,7,4]

In order traversal
1,  10R

1, 10R, 9R -> 1, 9R, 10R -> 1R, 9, 10R -> 9, 1R, 10R 

9, 1R, 2R, 10R -> 9R, 1 , 2R, 10 -> 9,1, 2R, 10

9, 1, 2R, 3R, 10 -> 9, 1R, 2, 3R, 10 -> 9, 2, 1R, 3R, 10

9, 2, 1R, 3R, 8R, 10 ->9, 2R, 1, 3, 8R, 10 

9, 2R, 1, 3, 8R, 7R, 10 -> 9, 2R, 1, 3, 7R, 8R, 10 -> 9, 2R, 1, 7, 3R, 8R, 10

9, 2R, 1, 7, 3R, 4R, 8R, 10 ->  9, 2R, 1, 7R, 3, 4R, 8, 10 -> 9, 7R, 2R, 1, 3, 4R, 8, 10 -> 9R, 7,  2R, 1, 3, 4R, 8, 10 -> 7, 2R, 1, 3, 4R, 9R, 8, 10





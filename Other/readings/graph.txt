When relation is mostly unrelated or 1-n, document model is more suitable

but as # of n-n relationship grows, relational and then graph model becomes more appropriate

Note that for vs and edges, they don't need to be of homogenous type at all =>
vertices:
1. uid
2. k-v pairs for properties
3. set of incoming edges
4. set of out going edges

edges
1. uid
2. k-v pairs for properties
3. marks what kind of relationship this edge represets
4. both ends of the edge

This naturally means we can store vs and es into 2 different edges

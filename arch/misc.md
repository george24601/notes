### Graph model 

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

### Search

spider->web -> build_data

search_data -> index -> rank

* search + build data to build index
* build index will generate the inversed index
* search index will analyze the search keywaord, and filter it roughtly by the search idnex
* rank will score and sort results, rank will return the first page result
* may parallize bucket search by partitioning by ranges
* can use bitmap and to improve the performance
* skip list to the most common appraoch for ordered LL union problem, to logn
* separate day db, hour data, month db, change only the hour db, and divide & conquer the search result

Hash vs range partition, range parititon has better extensibiilty with pre-defined block ranges (need help with incremental id)





The main idea behind the consistent hashing algorithm is to associate each cache with one or more hash value intervals where the interval boundaries are determined by calculating the hash of each cache identifier. (The hash function used to define the intervals does not have to be the same function used to hash the cached values. Only the range of the two functions need match.) If the cache is removed its interval is taken over by a cache with an adjacent interval. All the remaining caches are unchanged.

Consistent hashing is based on mapping each object to a point on the edge of a circle (or equivalently, mapping each object to a real angle). The system maps each available machine (or other storage bucket) to many pseudo-randomly distributed points on the edge of the same circle.

To find where an object should be placed, the system finds the location of that object's key on the edge of the circle; then walks around the circle until falling into the first bucket it encounters (or equivalently, the first available bucket with a higher angle). The result is that each bucket contains all the resources located between each one of its points and the previous points that belong to other buckets.

If a bucket becomes unavailable (for example because the computer it resides on is not reachable), then the points it maps to will be removed. Requests for resources that would have mapped to each of those points now map to the next highest points. Since each bucket is associated with many pseudo-randomly distributed points, the resources that were held by that bucket will now map to many different buckets. The items that mapped to the lost bucket must be redistributed among the remaining ones, but values mapping to other buckets will still do so and do not need to be moved.

A similar process occurs when a bucket is added. By adding new bucket points, we make any resources between those and the points corresponding to the next smaller angles map to the new bucket. These resources will no longer be associated with the previous buckets, and any value previously stored there will not be found by the selection method described above.

The portion of the keys associated with each bucket can be altered by altering the number of angles that bucket maps to.

nstead of mapping machine number  to a single point on the circle, we’ll map it to multiple points (“replicas”). In particular, let’s imagine that for each machine we pick out  points, by hashing onto the circle. 

virtual node number common to 32

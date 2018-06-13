Scenario
--------
Update cache without timeouts

Options
---------

1. Update DB, and then cache. Bad because 

	a. the case of two threads updating the same entries

	b. frequent write case. We update cache more than it is read

	c. In case of cache computed value, just delete the cache

2. Delete cache, update DB. Bad when one write, and one read between the cache delete and new db write. To fix it, need to sleep after db write, and delete cache again. Probably need to do that sync to avoid blocking

3. Update db, and then delete cache (Cache-aside pattern)

Note that from read POV, should update cache as empty even if the db has no value, to avoid penetration db. 

Scenario
-------
Sorted pagination

Uses redis list to store the order. Use a async process to init and refresh cache. Save a timestamp in the cache - when there is an update, renew the timestamp, the async job seems the timestamp changed, and then refresh cache


Scenario
--------
Counting

A counting service will store the counting result in the cache, when data cahbnes, use the counting service to update the count rather async db count


Scenario
---------
Refactoring dimension cache

Memory-based often hard to support in this case - often uses levelDB instead of memory only cache, e..g, memcached/redis


Note that multiple client may still hit cache at the same time to update - the cache stampede effect! - add a lock to solve. 

upon a cache miss a process will attempt to acquire the lock for that cache key and recompute it only if it acquires it

There are different implementation options for the case when the lock is not acquired:

Wait until the value is recomputed
Return a "not-found" and have the client handle the absence of the value properly
Keep a stale item in the cache to be used while the new value is recomputed
If implemented properly, locking can prevent stampedes altogether, but requires an extra write for the locking mechanism. Apart from doubling the number of writes, the main drawback is a correct implementation of the locking mechanism which also takes care of edge cases including failure of the process acquiring the lock, tuning of a time-to-live for the lock, race-conditions, and so on.


External recomputation
---------
This solution moves the recomputation of the cache value from the processes needing it to an external process. The recomputation of the external process can be triggered in different ways:

When the cache value approaches its expiration
Periodically
When a process needing the value encounters a cache miss
This approach requires one more moving part - the external process - that needs to be maintained and monitored. In addition, this solution requires unnatural code separation/duplication and is mostly suited for static cache keys (i.e., not dynamically generated, as in the case of keys indexed by an id).

Probabilistic early expiration
---------
the probability of performing the early recomputation increases as we get closer to the expiration of the value.

The following implementation based on an exponential distribution has been shown to be optimal in terms of its effectiveness in preventing stampedes and how early recomputations can happen.

Some caches enable you to specify the expiration period as an absolute value, or as a sliding value that causes the item to be removed from the cache if it is not accessed within the specified time.

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

A counting service will store the counting result in the cache, when data changes, use the counting service to update the count rather async db count


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


# Defend against stampede

0. happens when cache server restarts or many cache entries expire at the same time, so all traffics hit DB

1. Real db should have enough capacity in case of cache failure

2. HA cache, sharding, but additional cache on the caller side is very debatable

3. stagger the cache time out,e.g., add a randomized slacks 

# competing renew problem

1. in case we need only one renewl (e.g., leased tokens, or 1 thread per node), just use cron job in the backend instead of front end

2. add a timestamp to token, so don't renew too frequently

3. service layer will extend the renew period, and itself will renew, while others still think it is safe to use the cache

# cache penetration

1. look for a non-exist key for a long time -> a lot of traffic goes to DB too

2. need to cache empty results

3. For a key that does not exist for sure, use bloomfilter to filter


Persistance may consume much resource on high volumes  - maybe persist on separate disk. Although persistance helps recovery, and can support certain storage requirement

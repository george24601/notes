In KV backoff ops:
txnLock: write-write conflict
txnLockFast: read-write conflict

In such cases, the status of the lock is in Lock Resolve ops:
* wait expired
* expired
* not expired

latch is used to early detect txn conflict, so that write-write conflicts can be reduced, but we can turn it off for historical data which has little txn write conflict. so we can turn it off (which is the default) to reduce the memory usage. 

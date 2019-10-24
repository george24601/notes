Conflict: write-write conflict is easier to be exposed by the user

Retry trys only write sql but not read sql!, i.e., if we rely on the saved query results. Do not turn on the retry logic

write-write confict is heavy, done inside prewrite, check scheculer latch wait duration
 

Layers:
Transaction -> MVCC -> Raft KV -> Rocks DB

```
//return max version of the value <= version
MVCCGet(key, version)
MVCCScan(startKey, endKey, limit, version)

//write k-v at version, user is responsible for ensure auto-increment of user
MVCCPut(key, value, version)
```

Row: key: table id + row id, value: row value
index: table id + index id + index-column-value, value: rowid (non-unique, goes rowid will go to the index)
encoding should preserve order


Inside RocksDB, it stores

key -> all key version info //this is called metakey
key + version1 -> value at v1
key + version2 -> value at v2

Note we will split key with version value to avoid too huge updates


### Write in transaction 
Percolator based txn: almost decentralized 2PC. single point failure is the timestamp allocation. 

Isolation level: repeatable read

1. buffer all update/delete on client side. Pick one row as primary row, and others as secondary.

2. Prewrite primaryRow: 
	a. lock the primaryRow with the start time of current transaction by adding it to the metakey, i.e., key -> all key verison info pair 
	b. if there is other client locking the same primaryRow, or if there is any Write happening during [startTs +inf)
	, that means there is potental conflict - rollback a
	c. add key+startTs -> new value

3. Prewrite secondaryRow, follows similar steps of primaryRow, except that the content of the lock is startTS + primaryRow info

4. commit primary: 
	a. add a new vesion to meta with timestamp commitTs, with content startTs
	b. delete the lock in primary's meta key
	c. if commit failed, roll back the whole trascation, similar to how rollback works in prewrite stage 

5. commit secondaries asychly

----------

During read in transaction: Isolation level: repeatable read
1. check if the row is locked by checking is meta-key,wait until the lock is released or timeout, or try clearing an already cleared lock
2. read the meta-key, find the t <= startTS, and read at version t

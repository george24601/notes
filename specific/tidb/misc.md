Note it does not support SP, View, trigger, UDF, FK 

watch out for the case where index and shard data are not on the same shard : two cases where double scan won't be a problem! 

lock-free snapshot read: change to snapshot version,i.e., lock free

isolation: snapshot isolation

every mysql master can use a syncer to aggregate into the same tidb cluster (e.g., sharded db)

tidb binlog: backup in real time
dumper + loader for full backup restore => tidb-lighting: 1T data in 6 hours ingestion

at most 512 columns in a single table 

### optimize queries
ANALYZE TABLE
EXPLAIN
USE INDEX, FORCE INDEX, IGNORE INDEX

10 mins to gc expired MVCC

grafana port at 3000: lock resolve OPS : txn conflict

PD TSO: often bottleneck

one tikv node with multiple stores , each mapped to 1 harddrive

pd harder to scale up/down

SI is roughly as RR

1 index, 1 kv entry => more kv, more storage

best virtualization gives 30% penalty over physical machine

keep synclog-log = true

#### For dev 

Does not handle write skew, have to use select for update
on default, will have lost update problem, i.e., if both A and B read and then update the same entry, if A submit first, B 

### PD

PD leader is different from the etcd leader!

physical time + logical time
1. when PD becomes leader, will get last saved time from etcd, and hold until current time >= that value
2. apply a lease to etcd, within this window PD will be the TSO
3. client batchs n request and get TSs togehter from PD

### To split region
1. Leader peer sends request to PD
2. PD creates new region ID and peer ID, and return to leader peer
3. leader peer writes the split action into a raft log, and execute it at apply
4. Tikv tells PD, PD updates cache and persist it to etcd

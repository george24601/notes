HB a common source to let raftstore CPU become bottleneck - propose wait duration: time between sending the request to raftstore to when the raftstore processes the request

raft-base-tick-interval - increase heartbeat interval

Check tikv's Worker pending tasks to see if task is accumulating

txn-local-latchs: default is turned on to pre-emptive txn conflict

lock-free snapshot read: change to snapshot version,i.e., lock free. History read is possible by setting @@tidb_snapshot

isolation: snapshot isolation (roughly RR)

dumper + loader for full backup restore => tidb-lighting: 1T data in 6 hours ingestion

pd harder to scale up/down

best virtualization gives 30% penalty over physical machine

### PD

PD leader is different from the etcd leader! PD is on active-standby, uses the etcd for leader election

physical time + logical time
1. when PD becomes leader, will get last saved time from etcd, and hold until current time >= that value
2. apply a lease to etcd, within this window PD will be the TSO
3. client batchs n request and get TSs togehter from PD

based on experience, 400M rows of data takes 10min+ to analyze (default setting, tidb_build_stats_concurrency=4).

A root task refers to a computing task that is executed in TiDB.

The PD TSO Wait Duration actually contains the PD TSO RPC Duration. The “Wait” here is actually the asynchronous wait time, that is, the time from the asynchronous acquisition of the TSO to the time when the transaction actually needs to use the TSO to read/write data. 

From me: PD TSO RPC duration, 99 at 1.74 ms makes way more sense

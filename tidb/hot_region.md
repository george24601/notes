Use split region to pre-split hot regions

### To split region
1. Leader peer sends request to PD
2. PD creates new region ID and peer ID, and return to leader peer
3. leader peer writes the split action into a raft log, and execute it at apply
4. Tikv tells PD, PD updates cache and persist it to etcd

for non-int PK will use the auto-incr rowid, use `SHARD_ROW_ID_BITS`

check Scheduler, balance-hot-region-scheduler, its value means hot region balancing is happening


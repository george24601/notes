
### older starts
block-cache? write-buffer?

leader sends snapshot to follower - common cause to stress io

store maintains the local peers of different regions,which will drive the tick (by default every 100ms)

generate and apply snapshots are slow, that is why they are async
region_heartbeat: report to PD, e.g., # of peers

store_heartbeat: report to PD, e.g., current free space

ask_split/report_split: region report to PD before and after the split

tikv and etcd membership change is slightly different from the Raft paper: apply the config change log first, and then config change

leader heartbeats once every 10 ticks to follower, if follower didn't receive heartbeat after a while, it restarts election tikv defaults to 50. the tick is the unit of time (configurable)

tikv tick is 100 ms 

step: receives messages from other raft nodes

advance: tell raft ready to go to the next step

when external discovers that RawNode is ready, save snapshot to storage, and asyncly apply snapshot data to statemachine(snapshot is in general huge)

when split the region, apply the split region to the raft statement, once it is successfully applied, we know the op is successfully copied. then elect leader for the new region

raft rebalance: add replica, transfer leadership, remove local replica

when the leader has region stale error, tikv client will request from metadata the renew the routing cache

heartbeats to pd with region info, PD's etcd is just cached routing info

### older ends


Each TiKV contains two RocksDB instances. One of them is used to store Raft Log, which we call Raft RocksDB, and the other is to store the actual data, which we call KV RocksDB.

A TiKV store contains multiple Regions. In Raft RocksDB, we use the Region ID as the prefix of the key, which is combined with Raft Log ID to uniquely identify a Raft Log

RocksDB supports column families, so it can directly correspond to the column families in Percolator. In TiKV, we use the Default CF in RocksDB to directly correspond to the Data CF in Percolator, and use Lock and Write CFs of the same name.

Use big-endian to convert the timestamp to a 8-byte value, and then invert the bytes by bit.
Combine the inverted bytes with the original key for storage in RocksDB

(small data case) For TiKV, the Lock CF will be read during the Commit phase to determine transaction conflicts, so we can get data from the Lock CF and write it to the Write CF.

Because PK is unique, we can use t + Table ID + PK to uniquely represent a row of data, and the value is this row of data. For the unique index, we use i + Index ID + name to represent it, and the value is the corresponding PK

For the ordinary index, we use i + Index ID + age + PK because no uniqueness constraint is required. The value is empty. Because the PK must be unique, even if the two rows of data have the same age, they will not conflict. To query with the ordinary index, TiKV seeks the data with the first key that is greater than or equal to the i + Index ID + age key, and then see if the prefix matches. If the prefix matches, TiKV decodes the corresponding PK, and get the actual data through it.




1. check if the row is locked by checking is meta-key,wait until the lock is released or timeout, or try clearing an already cleared lock
2. read the meta-key, find the t <= startTS, and read at version t

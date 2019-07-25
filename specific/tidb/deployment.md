### Dev

* 2 * TiDB: 16 core + 32G RAM
* 3 * TiKV: 16 core + 32G RAM 200 - 300 G SSD
* 3 * PD: 4 core + 8G RAM + 100 G+ SSD

### New Prod

Minimum:
* 2 * TiDB: 32 core + 64G RAM
* 3 * TiKV: 32 core + 64G RAM 200 - 500 G SSD
* 3 * PD: 8 core + 16G RAM + 200 G+ SSD

Example prod:
* c5.4xlarge x4: 16, 32, 8GB (EBS) (for both TiDB and PD)
* i3.4xlarge x10: 16, 122, 1900GB x2 (ephemeral) (for TiKV)

TiDB is going to be deployed in 2 parts using a Helm Chart; tidb-operator and tidb-cluster.
tidb-operator consists of:
ReplicaSets of:
tidb-controller-manager
tidb-scheduler

tidb-cluster consists of:
StatefulSets of:
pd
tidb
tikv
ReplicaSets of:
discovery
monitor


Because TiDB by default will use lots of file descriptors, the worker node and its Docker daemon's ulimit must be configured to greater than 1048576:

from google pov, can accept latency of network drive => inspires persistent volumne. on average google's db write latency is 100 - 150 ms

A DaaS deployment:
TiDB: 4
TiKV: 7 * 3
PD: 3

zhihu: 40k writes per sec peak, 30k+ qps P99 = 25ms, 
DM + lighting import 1 tri for 4 days

xiaohongshu: write latency LT 20ms, 10 tikv + 3pd
write 5k per sec, batch size LT 100 seems good enough

### TiDB ops

The suggested connection count should be less than 500 under OLTP workload, pay close attention to whether the number of connections is balanced between multiple tidb-server instances.

The suggested .999 duration of the query should be less than 500ms under OLTP workload

1. Connection Count, the suggested connection count should be less than 500 under OLTP workload, pay close attention to whether the number of connections is balanced.

2. Heap Memory, for OLTP workloads, the memory usage should be less than 3GB when local-latch is enabled. Otherwise if the local-latch is disabled, the memory usage should be less than 1GB.

Transaction Retry Num should be less tan 3 times. If it is more than 6 times, means that there are many write-write conflicts

1. Lock Resolve OPS - Unlocking frequency caused by write-write/read-write conflicts. Reference values: less than 500 for both expired and not_expired

2. KV Backoff OPS - number of times to wait and retry transactions are blocked by locks or region routing has been updated.
Reference values：less than 500 for both `txnLockFast` and `txnLock`. Region miss error should be less than 5000 in importing data case.

1. PD TSO Wait Duration - Aggregated latency of TiDB obtaining timestamps from PD. This value will be high if the tidb-server has a very high workload

### TiKV

The suggested .99 latch wait duration should be less than 20ms.  If the latch wait duration is high, it means that the conflicts is high or should enlarge

The async-write duration is the raft write duration. It consists of:
1. propose wait duration,
2. append log duration,
3. commit log duration,
4. apply wait duration,
5. apply log duration.

The suggested .99 async-write duration should be less than 200ms.

The suggested propose wait duration should be less than 50ms.
If propose wait duration is high, it means that the raftstore is busy. It may because append raft log is slow or the CPU of raftstore is high.

The CPU usage of raftstore should be less than store-pool-size * 85%.

The suggested .99 append log duration should be less than 50ms.o

The suggested .99 apply wait duration should be less than 100ms. If the apply wait duration is high it means the apply pool is busy or the write db duration is high.

The CPU usage of apply pool should be less than apply-pool-size * 90%.

The suggested .99 apply log duration should be less than 100ms.

The suggested .99 coprocessor wait duration should be less than 50ms. If it is high, it means the coprocessor is busy.

the slow log file can be directly analyzed with pt-query-digest. slow-threshold can be modified by the configuration file, which is set to 300ms by default. slow-query-file is set to tidb-slow.log by default


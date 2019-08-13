deploy/log for logs, by default 300 MS

open general_log by /settings API

##Important metrics:
Statement OPS: number of sql executed
Duration: SQL executed time
Trasaction OPs: executed txns
Lock resolve ops: txn conflict nubmers (LT 20 ms)
PD TSO wait duration: PD to get time


co-processor request duration: tikv query time
raftstore CPU: more than 80% needs to increase instance
coprocessor CPU: tikv query CPU 

store status: tikv store status: should be up most of time

pd_tidb_handle_requests_duration- use pprof to analyze its load

#common warnings
channel full
report failures
peer is not leader (may be false alarm)
region is stale
server is busy

use grpc message count's prewrite and commit to identify potential hot servers
co-processor good way to check read hotspot

KV backoff ops: check conflicts

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

TiDB alert rules are configured in Prometheus not Grafana.

Currently, the alert rules are defined in the configmap, this can be changed by kubectl edit configmap
The alertmanager is not managed by tidb-operator, users should deploy and configure alertmanager themselves. And usually only one alertmanager is needed for the whole platform
We’ll deploy promtheus-operator in our cluster too.

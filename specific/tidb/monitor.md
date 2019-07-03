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
disk latency: how slow is slow?

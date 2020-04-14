Note speical settings needed to truly enable prepared statements. Most likely you do not turn it on yet

The recommended startup sequence: PD -> TiKV -> Pump -> TiDB -> Drainer

HB a common source to let raftstore CPU become bottleneck - propose wait duration: time between sending the request to raftstore to when the raftstore processes the request

raft-base-tick-interval - increase heartbeat interval

Check tikv's Worker pending tasks to see if task is accumulating

pd harder to scale up/down

best virtualization gives 30% penalty over physical machine

### PD

PD leader is different from the etcd leader! PD is on active-standby, uses the etcd for leader election

physical time + logical time
1. when PD becomes leader, will get last saved time from etcd, and hold until current time >= that value
2. apply a lease to etcd, within this window PD will be the TSO
3. client batchs n request and get TSs togehter from PD

The PD TSO Wait Duration actually contains the PD TSO RPC Duration. The “Wait” here is actually the asynchronous wait time, that is, the time from the asynchronous acquisition of the TSO to the time when the transaction actually needs to use the TSO to read/write data. 

mysql dump 4-5G per min, try to limit mydumper file to 64MB

lightining 150-200G/h note lighting is faster for full import - 7 hours for 1 TB

lightning -> tikv importer, which talks to the PD server, note that tidb-lightening does not talk to PD directly

lightning and importer are resource intensive, recommend two separate servers

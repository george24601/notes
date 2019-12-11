XA based 2PC + 2PL

OCC+2PL+MVCC

uses ZK for pd control

need to specify sharding key, which is prob OK

webank uses TDSQL noshard

10 - 50 ms, 2 ms latency

webank core is on TDSQL, supplement is on Tidb due to their deployment limitation

each replica is a mysql instance, has a separate shceulder for leader election, powered by ZK

cross shard txn

CDB for TDSQL is coming


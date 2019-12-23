Object management
* JSON usage
* B+tree and LSM tree
* table and index health and stats

Monitoring and alerting
* Prometheus architecture
* how are metrics uploaded
* important metrics to watch out for
* config AlertManager
* common problems

Tidb internals
1. parameters affecting tidb startup.
2. how do you know it started already
3. how to find DDL/stats/GC owner
4. what does tidb do when a connection is created
5. token limit
6. TCP Keep Alive
7. common external ports

Coprocessor
* operator push down
* execution engine model

tidb relational model
* information schema
* `mysql` database
* relationship mapping to KV

DML
* data write process
* data read process
* replace vs insert on duplicate
* lazy check in insertion

DDL
* drop table, truncate table, add column - how do they work
* troubleshooting DDL
* add index - how does it work and optimization

RockesDB
* column family
* LSM - how it works, and pros and cons
* compaction - how does it work?
* how data write works in rocks db
* rocksdb major parameters

Raft
* roles inside raft and mechanism
* raft inside tikv
* multi-raft
* raft vs paxos
* raft read/write inside tikv

Distributed transaction
* percolator
  * write
  * read
* tidb
 * write
 * read
 * clear lock

tidb txn
* statement submit and rollback
* txn submit and rollback
* write conflict
* write-read conflict
* network timeout error
* txn retry - how is it implemented?
* control txn try, logs and metrics

Tidb System optimization
* bottleneck for read workload and write workload
* read hotspot
* write hotspot
* tidb server monitoring
* SHARD_ROW_ID_BITS

SQL execution plan
* slow query log
* read execution plan
* CBO
* driving table
* how is data located
* index theory and usage

Development
* isolation level in tidb
* unreliable affected rows problem
* avoid lost update problem
* Counter for flash sale problem
* No support for PROPAGATION_NESTED
* auto incr id in tidb
* how to design for auto incr id in tidb
* Foreign key
* insert checks for uniqueness only on commit

Tidb parser
* how does it work?
* parser error and handling

SQL optimization
* TiDB Logical Optimizatio
* TiDB Physical Optimization
* TiDB Ranger
* TiDB Plan Cache for Prepared statements 

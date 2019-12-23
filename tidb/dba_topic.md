Cluster management
* run sysbench against tidb
* run tidb-bench to simulate OLTP workload
* rolling upgrade
* scale out

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

PD
* etcd, how does that work
* tikv metadata and management 
  * node, region
  * How metadata is reported
* PD coordination algorithm
  * how region migration works
  * Use label to tune migration
  * region split and merge
  * pd-ctl

MySQL to tidb
* DM, how does that work
  * install, config, monitoring
  * relay logs, how does it work?
  * Binlog Replication, how does it work?
* troubleshooting
  * use checkpoint to identify sync status
  * relay-log exception
  * sync disconnected

Export from tidb
* tidb-binlog design and implementation
* pump design and implementaion
* drainer design and implementaiton
* take pump/drainer offline
* binlog log and metrics
* tidb-binlog: depoly pump and drainer by ansible
* troubleshooting

TiDB Lightning 
* Core import process (Lightning, Importer) 
* Post-process (Checksum, Analyze, Auto-inc ID) 
* Table filter 
* Checkpoints
* lightning: use ansible to deploy Lightning, tikv-importer, and tidb-lightning
* monitoring

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

SQL execution plan
* slow query log
* read execution plan
* CBO
* driving table
* how is data located
* index theory and usage

TIKV system optimization
* write bottleneck
* read bottleneck
* rocksdb optimization

TiDB Statistics 
* CM-Sketch, Selectivity
* Analyze Table
* Query Feedback

TiDB Execution Engine 
* Chunk and vectorization
* expression calculation: vectorization + sql mode behaviors
* Hash Aggregate, Stream Aggregate 
* IndexReader, TableReader, IndexLookupReader 
* TiDB Insert/Update/Delete/Replace implementations 
* DistSQL's Cop, how does it work? How does CopIterator work?
* Elastic OLTP&OLAP, Batch Size Control

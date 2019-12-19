sync diff is often done by xor

business and traffic replay

traffic replay via dbreplay to tidb, which sits on the nginx cluster

pump and drainer from mysql to tidb, and then tidb to old mysql master

timestamp based dbcompare 
read-write traffic grey at the same time, by the db, new data in tidb is synced back to mysql

failover to the aurora in case of most critical error

### Steps

* Build the TiDB cluster 
  * disable explicit txn retry
  * Confirm GC time
  * Set `max_execution_time`
* DM into TiDB with real time.
  * Diff by time or int id 	
  * Use `BIT_XOR` over all rows over a time period
  * Can reuse sync-diff inspector, what if the data keeps changing?
* Option1:  dbreplay real time traffic replay. 
  * decrypt mysql packets on the network drive
  * analyze MySql protocol
  * record and replay
  * need to check for error and latency, and verify response
* Option2: stop data sync, use traffic replay tool to copy the online traffic and read/write tidb/mysql at the same time
  * write to mysql to return the incremental id, and use that id to write to tidb
* Option 3: double write at the applicaiton level
* Domain check
* Setup tidb DR cluster

Periodically check payment endpoint to see if TiDB is available

mysqldump weekly, drainer PB binlog backup every 5 mins

mysql dump 4-5G per min
loader 28G/h lightining 200G/h



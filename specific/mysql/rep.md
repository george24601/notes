Binlog dump thread.  The master creates a thread to send the binary log contents to a slave when the slave connects. This thread can be identified in the output of SHOW PROCESSLIST on the master as the Binlog Dump thread.

The binary log dump thread acquires a lock on the master's binary log for reading each event that is to be sent to the slave. As soon as the event has been read, the lock is released, even before the event is sent to the slave.
`

For example, if you are using InnoDB tables and the MySQL server processes a COMMIT statement, it writes many prepared transactions to the binary log in sequence, synchronizes the binary log, and then commits this transaction into InnoDB. If the server crashes between those two operations, the transaction is rolled back by InnoDB at restart but still exists in the binary log. Such an issue is resolved assuming --innodb_support_xa is set to 1, the default. Although this option is related to the support of XA transactions in InnoDB, it also ensures that the binary log and InnoDB data files are synchronized. For this option to provide a greater degree of safety, the MySQL server should also be configured to synchronize the binary log and the InnoDB logs to disk before committing the transaction. The InnoDB logs are synchronized by default, and sync_binlog=1 can be used to synchronize the binary log. The effect of this option is that at restart after a crash, after doing a rollback of transactions, the MySQL server scans the latest binary log file to collect transaction xid values and calculate the last valid position in the binary log file. The MySQL server then tells InnoDB to complete any prepared transactions that were successfully written to the to the binary log, and truncates the binary log to the last valid position. This ensures that the binary log reflects the exact data of InnoDB tables, and therefore the slave remains in synchrony with the master because it does not receive a statement which has been rolled back.

By default, the binary log is synchronized to disk at each write (sync_binlog=1). If sync_binlog was not enabled, and the operating system or machine (not only the MySQL server) crashed, there is a chance that the last statements of the binary log could be lost. To prevent this, enable the sync_binlog system variable to synchronize the binary log to disk after every N commit groups. 

Within an uncommitted transaction, all updates (UPDATE, DELETE, or INSERT) that change transactional tables such as InnoDB tables are cached until a COMMIT statement is received by the server. At that point, mysqld writes the entire transaction to the binary log before the COMMIT is executed.

Binary logging is done immediately after a statement or transaction completes but before any locks are released or any commit is done. This ensures that the log is logged in commit order

slave stores events received from the master in its relay log until they can be executed. The relay log has the same format as the binary log.


### semi-sync replication

MySQL also supports semi-synchronous replication, where the master does not confirm transactions to the client until at least one slave has copied the change to its relay log, and flushed it to disk. 
The slave acknowledges receipt of a transaction's events only after the events have been written to its relay log and flushed to disk.

If a timeout occurs without any slave having acknowledged the transaction, the master reverts to asynchronous replication. When at least one semisynchronous slave catches up, the master returns to semisynchronous replication.

Semisynchronous replication must be enabled on both the master and slave sides. If semisynchronous replication is disabled on the master, or enabled on the master but on no slaves, the master uses asynchronous replication.

If the master commits but a crash occurs while the master is waiting for acknowledgment from a slave, it is possible that the transaction may not have reached any slave. This is not that big of an issue as the commit will not be returned to the application in this case. It is the application’s task to retry the transaction in the future. What is important to keep in mind is that, when the master failed and a slave has been promoted, the old master cannot join the replication chain. Under some circumstances this may lead to conflicts with data on the slaves (when master crashed after the slave received the binary log event but before master got the acknowledgement from the slave). Thus the only safe way is to discard the data on the old master and provision it from scratch using the data from the newly promoted master.

AFTER_SYNC (the default): The master writes each transaction to its binary log and the slave, and syncs the binary log to disk. The master waits for slave acknowledgment of transaction receipt after the sync. Upon receiving acknowledgment, the master commits the transaction to the storage engine and returns a result to the client, which then can proceed.

### GTID

These GTIDs identify a specific location within the MySQL binlog across machines. This means that a consumer reading from a binlog on one MySQL server can switch over to the other, provided that both servers have the data available

When using GTIDs, each transaction can be identified and tracked as it is committed on the originating server and applied by any slaves; this means that it is not necessary when using GTIDs to refer to log files or positions within those files when starting a new slave or failing over to a new master, which greatly simplifies these tasks. Because GTID-based replication is completely transaction-based, it is simple to determine whether masters and slaves are consistent; as long as all transactions committed on a master are also committed on a slave, consistency between the two is guaranteed.

GTIDs are always preserved between master and slave. This means that you can always determine the source for any transaction applied on any slave by examining its binary log. In addition, once a transaction with a given GTID is committed on a given server, any subsequent transaction having the same GTID is ignored by that server. Thus, a transaction committed on the master can be applied no more than once on the slave, which helps to guarantee consistency.

GTID assignment distinguishes between client transactions, which are committed on the master, and replicated transactions, which are reproduced on a slave. When a client transaction is committed on the master, it is assigned a new GTID, provided that the transaction was written to the binary log. Client transactions are guaranteed to have monotonically increasing GTIDs without gaps between the generated numbers. If a client transaction is not written to the binary log (for example, because the transaction was filtered out, or the transaction was read-only), it is not assigned a GTID on the server of origin.

The MySQL system table mysql.gtid_executed is used to preserve the assigned GTIDs of all the transactions applied on a MySQL server, except those that are stored in a currently active binary log file.

The source_id identifies the originating server. Normally, the server's server_uuid is used for this purpose. The transaction_id is a sequence number determined by the order in which the transaction was committed on this server;

This format is used to represent GTIDs in the output of statements such as SHOW SLAVE STATUS as well as in the binary log. They can also be seen when viewing the log file with mysqlbinlog --base64-output=DECODE-ROWS or in the output from SHOW BINLOG EVENTS.

As written in the output of statements such as SHOW MASTER STATUS or SHOW SLAVE STATUS, a sequence of GTIDs originating from the same server may be collapsed into a single expression, as shown here.

If a GTID was assigned for the transaction, the GTID is externalized non-atomically (very shortly after the transaction is committed) by adding it to the set of GTIDs in the gtid_executed system variable (@@global.gtid_executed). This GTID set contains a representation of the set of all committed GTID transactions. With binary logging enabled (as required for the master), the set of GTIDs in the gtid_executed system variable is a complete record of the transactions applied, but the mysql.gtid_executed table is not, because the most recent history is still in the current binary log file.


### Specific tools

cannal/maxwell vs kafka connect
* Deployment, unbalanced resources, no HA
* Note mysql to ES binlog replication is a bit tricky

* maxwell has HA problem

### Canal
ZK for HA
No FK or trigger support
Memory hungry
github start is order of magnitude less than than canal

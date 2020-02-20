With asynchronous replication, the master writes events to its binary log and slaves request them when they are ready. There is no guarantee that any event will ever reach any slave. It’s a loosely coupled master-slave relationship, where:

Master does not wait for Slave.
Slave determines how much to read and from which point in the binary log.
Slave can be arbitrarily behind master in reading or applying changes.

MySQL also supports semi-synchronous replication, where the master does not confirm transactions to the client until at least one slave has copied the change to its relay log, and flushed it to disk. 

The slave acknowledges receipt of a transaction's events only after the events have been written to its relay log and flushed to disk.

If a timeout occurs without any slave having acknowledged the transaction, the master reverts to asynchronous replication. When at least one semisynchronous slave catches up, the master returns to semisynchronous replication.

Semisynchronous replication must be enabled on both the master and slave sides. If semisynchronous replication is disabled on the master, or enabled on the master but on no slaves, the master uses asynchronous replication.

If the master commits but a crash occurs while the master is waiting for acknowledgment from a slave, it is possible that the transaction may not have reached any slave. This is not that big of an issue as the commit will not be returned to the application in this case. It is the application’s task to retry the transaction in the future. What is important to keep in mind is that, when the master failed and a slave has been promoted, the old master cannot join the replication chain. Under some circumstances this may lead to conflicts with data on the slaves (when master crashed after the slave received the binary log event but before master got the acknowledgement from the slave). Thus the only safe way is to discard the data on the old master and provision it from scratch using the data from the newly promoted master.

### GTID

Starting with MySQL 5.6, MySQL introduced the concept of global transaction IDs. These GTIDs identify a specific location within the MySQL binlog across machines. This means that a consumer reading from a binlog on one MySQL server can switch over to the other, provided that both servers have the data available

When using GTIDs, each transaction can be identified and tracked as it is committed on the originating server and applied by any slaves; this means that it is not necessary when using GTIDs to refer to log files or positions within those files when starting a new slave or failing over to a new master, which greatly simplifies these tasks. Because GTID-based replication is completely transaction-based, it is simple to determine whether masters and slaves are consistent; as long as all transactions committed on a master are also committed on a slave, consistency between the two is guaranteed.

GTIDs are always preserved between master and slave. This means that you can always determine the source for any transaction applied on any slave by examining its binary log. In addition, once a transaction with a given GTID is committed on a given server, any subsequent transaction having the same GTID is ignored by that server. Thus, a transaction committed on the master can be applied no more than once on the slave, which helps to guarantee consistency.

GTID assignment distinguishes between client transactions, which are committed on the master, and replicated transactions, which are reproduced on a slave. When a client transaction is committed on the master, it is assigned a new GTID, provided that the transaction was written to the binary log. Client transactions are guaranteed to have monotonically increasing GTIDs without gaps between the generated numbers. If a client transaction is not written to the binary log (for example, because the transaction was filtered out, or the transaction was read-only), it is not assigned a GTID on the server of origin.

The MySQL system table mysql.gtid_executed is used to preserve the assigned GTIDs of all the transactions applied on a MySQL server, except those that are stored in a currently active binary log file.

The source_id identifies the originating server. Normally, the server's server_uuid is used for this purpose. The transaction_id is a sequence number determined by the order in which the transaction was committed on this server;

This format is used to represent GTIDs in the output of statements such as SHOW SLAVE STATUS as well as in the binary log. They can also be seen when viewing the log file with mysqlbinlog --base64-output=DECODE-ROWS or in the output from SHOW BINLOG EVENTS.

As written in the output of statements such as SHOW MASTER STATUS or SHOW SLAVE STATUS, a sequence of GTIDs originating from the same server may be collapsed into a single expression, as shown here.

If a GTID was assigned for the transaction, the GTID is externalized non-atomically (very shortly after the transaction is committed) by adding it to the set of GTIDs in the gtid_executed system variable (@@global.gtid_executed). This GTID set contains a representation of the set of all committed GTID transactions. With binary logging enabled (as required for the master), the set of GTIDs in the gtid_executed system variable is a complete record of the transactions applied, but the mysql.gtid_executed table is not, because the most recent history is still in the current binary log file.

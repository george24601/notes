### Shared and Exclusive Locks
InnoDB implements standard row-level locking where there are two types of locks, shared (S) locks and exclusive (X) locks.

A shared (S) lock permits the transaction that holds the lock to read a row.

An exclusive (X) lock permits the transaction that holds the lock to update or delete a row.

### Intention Locks

InnoDB supports multiple granularity locking which permits coexistence of row locks and table locks.

For example, a statement such as LOCK TABLES ... WRITE takes an exclusive lock (an X lock) on the specified table. To make locking at multiple granularity levels practical, InnoDB uses intention locks. Intention locks are table-level locks that indicate which type of lock (shared or exclusive) a transaction requires later for a row in a table.

Before a transaction can acquire a shared lock on a row in a table, it must first acquire an IS lock or stronger on the table.

Before a transaction can acquire an exclusive lock on a row in a table, it must first acquire an IX lock on the table.

Intention locks do not block anything except full table requests (for example, LOCK TABLES ... WRITE). The main purpose of intention locks is to show that someone is locking a row, or going to lock a row in the table.

### Record Locks 

A record lock is a lock on an index record. For example, SELECT c1 FROM t WHERE c1 = 10 FOR UPDATE; prevents any other transaction from inserting, updating, or deleting rows where the value of t.c1 is 10.

Record locks always lock index records, even if a table is defined with no indexes. For such cases, InnoDB creates a hidden clustered index and uses this index for record locking.

### Gap Locks

A gap lock is a lock on a gap between index records, or a lock on the gap before the first or after the last index record. For example, SELECT c1 FROM t WHERE c1 BETWEEN 10 and 20 FOR UPDATE; prevents other transactions from inserting a value of 15 into column t.c1, whether or not there was already any such value in the column, because the gaps between all existing values in the range are locked.

A gap might span a single index value, multiple index values, or even be empty.

Gap locking is not needed for statements that lock rows using a unique index to search for a unique row.

Gap locks in InnoDB are “purely inhibitive”, which means that their only purpose is to prevent other transactions from inserting to the gap.

### Next-Key Locks
A next-key lock is a combination of a record lock on the index record and a gap lock on the gap before the index record.

InnoDB performs row-level locking in such a way that when it searches or scans a table index, it sets shared or exclusive locks on the index records it encounters. Thus, the row-level locks are actually index-record locks. A next-key lock on an index record also affects the “gap” before that index record.

That is, a next-key lock is an index-record lock plus a gap lock on the gap preceding the index record.

### Insert Intention Locks

### AUTO-INC Locks

In the simplest case, if one transaction is inserting values into the table, any other transactions must wait to do their own inserts into that table, so that rows inserted by the first transaction receive consecutive primary key values.

To use the AUTO_INCREMENT mechanism with an InnoDB table, an AUTO_INCREMENT column must be defined as part of an index such that it is possible to perform the equivalent of an indexed SELECT MAX(ai_col) lookup on the table to obtain the maximum column value.


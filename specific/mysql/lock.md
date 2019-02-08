row-locks uses 2PL, i.e., acquire on need, and release when the txn is over
each data uses the auto-incrementing transaction id as the version, i.e., row_trx_id

HWM: > means not yet started txn
LWM: < means commited txns
In the middle means not yet started txns


### Shared and Exclusive Locks
InnoDB implements standard row-level locking where there are two types of locks, shared (S) locks and exclusive (X) locks.

A shared (S) lock permits the transaction that holds the lock to read a row.

An exclusive (X) lock permits the transaction that holds the lock to update or delete a row.

UPDATE, DELETE are on row-level locks, LOCK TABLE..READ and LOCK TABLE ...WRITE are on full table lock

### Intention Locks

InnoDB supports multiple granularity locking which permits coexistence of row locks and table locks.

For example, a statement such as LOCK TABLES ... WRITE takes an exclusive lock (an X lock) on the specified table. To make locking at multiple granularity levels practical, InnoDB uses intention locks. Intention locks are table-level locks that indicate which type of lock (shared or exclusive) a transaction requires later for a row in a table.

Before a transaction can acquire a shared lock on a row or a table, it must first acquire an intention to share (IS) lock or stronger on the TABLE.

Before a transaction can acquire an exclusive lock on a row in a table, it must first acquire an IX lock on the TABLE.

Intention locks do not block anything except full table requests (for example, LOCK TABLES ... WRITE). The main purpose of intention locks is to show that someone is locking a row, or going to lock a row in the table, BUT IT WILL CONFLICT S AND X locks 

SELECT ... LOCK IN SHARE MODE: always requires IS lock
SELECT ... FOR UPDATE: needs IX lock



### Record Locks 

A record lock is a lock on an INDEX RECORD. For example, SELECT c1 FROM t WHERE c1 = 10 FOR UPDATE; prevents any other transaction from inserting, updating, or deleting rows where the value of t.c1 is 10. Most likely on the clustered index

Record locks always lock index records, even if a table is defined with no indexes. For such cases, InnoDB creates a hidden clustered index and uses this index for record locking.

### Gap Locks

A gap lock is a lock on a gap between index records, or a lock on the gap before the first or after the last index record. For example, SELECT c1 FROM t WHERE c1 BETWEEN 10 and 20 FOR UPDATE; prevents other transactions from inserting a value of 15 into column t.c1, whether or not there was already any such value in the column, because the gaps between all existing values in the range are locked.

A gap might span a single index value, multiple index values, or even be empty.

Gap locking is not needed for statements that lock rows using a unique index to search for a unique row.

Gap locks in InnoDB are “purely inhibitive”, which means that their only purpose is to prevent other transactions from inserting to the gap.

used only during Repeatable Read  and Serializable isolation level. Note that RR does NOT fully prevent phantom read

e.g., suppose you have index with values 10,11,13, and 20 then the  gap lock (-INF, 10], (10, 11], (11,13].... The definition is always < + <=

Note that table locks are implemented by gap locks!

deadlock caused by gap lock??

### Next-Key Locks

A next-key lock is a combination of a record lock on the index record AND a gap lock on the GAP before the index record. 

InnoDB performs row-level locking in such a way that when it searches or scans a table index, it sets shared or exclusive locks on the index records it encounters. Thus, the row-level locks are actually index-record locks. A next-key lock on an index record also affects the “gap” before that index record. 

Mainly to avoid phatom read,i.e., range returns more results as we go!

Note during the run it IS implemented as a combination of row lock and then gap lock

### Insert Intention Locks

for insert lock, based on gap lock, but will they need not wait for each other if they are not inserting at the same postion within the gap, 



### AUTO-INC Locks

In the simplest case, if one transaction is inserting values into the table, any other transactions MUST WAIT to do their own inserts into that table, so that rows inserted by the first transaction receive consecutive primary key values.

To use the AUTO_INCREMENT mechanism with an InnoDB table, an AUTO_INCREMENT column must be defined as part of an index such that it is possible to perform the equivalent of an indexed SELECT MAX(ai_col) lookup on the table to obtain the maximum column value.

```sql
SELECT * FROM table WHERE id =?; --executes snapshot reads, i.e., no lock involved for lower than serializable isolation level (IL) 

SELECT * FROM table WHERE id =? LOCK IN SHARE MODE -- add S locks to  the record

SELECT * FROM table WHERE id =? FOR UPDATE -- add X to lock to the record
SELECT * FROM table WHERE name = 'aaa' FOR UPDATE -- lock the full table by next key locks on all rows in the clustered index. Use show engine innodb status


```

### Under RC or RU

no gap lock involved

```
SELECT * FROM TABLE WHERE NUM = 200 -- snaphshot reads 
SELECT * FROM TABLE WHERE NUM > 200 -- snaphshot reads 
SELECT * FROM TABLE WHERE NUM = 200 LOCK IN SHARE MODE -- S on clustered index, current read 
SELECT * FROM TABLE WHERE NUM > 200 LOCK IN SHARE MODE -- S on clustered index , current read

SELECT * FROM TABLE WHERE NUM = 200 FOR UPDATE-- X on clustered index, current read 
SELECT * FROM TABLE WHERE NUM > 200 FOR UDPATE-- X on clustered index, current read 
```
Note under RC or RU, mysql will release the unqualified rows immediately during FTS. Therefore, it appears as if the lock status is similar to scanning on cluster index

### Under RR or Serializable

```
SELECT * FROM TABLE WHERE NUM = 200 -- snaphshot reads  on RR, in effect FTL on Serializable
SELECT * FROM TABLE WHERE NUM > 200 -- snaphshot reads  on RR, in effect FTL on Serializable
SELECT * FROM TABLE WHERE NUM = 200 LOCK IN SHARE MODE -- S on all rows + gap locks
SELECT * FROM TABLE WHERE NUM > 200 LOCK IN SHARE MODE -- S on all rows + gap locks

SELECT * FROM TABLE WHERE NUM = 200 FOR UPDATE-- X on clustered index + gap locks
SELECT * FROM TABLE WHERE NUM > 200 FOR UDPATE-- X on clustered index + gap locks

SELECT * FROM TABLE WHERE ID = 200 -- snaphshot reads  on RR, S  on Serializable
SELECT * FROM TABLE WHERE ID > 200 -- snaphshot reads  on RR,  S + gap lock from (200...) on Serializable
SELECT * FROM TABLE WHERE ID = 200 LOCK IN SHARE MODE -- current reads+ S on RR 
SELECT * FROM TABLE WHERE ID > 200 LOCK IN SHARE MODE -- S + gap lock from (200...)

SELECT * FROM TABLE WHERE ID = 200 FOR UPDATE-- current read X on clustered index 
SELECT * FROM TABLE WHERE ID > 200 FOR UDPATE-- X on clustered index + gap locks from ID (200....
```

Snapshot read means Consistent nonlocking read on the rollback segment, i.e., historical snapshot

normal select read is always snapshot read, unless explicitly ask for locking, RR reads on a fixed version though

SHOW PROCESSLIST to see current statement's state

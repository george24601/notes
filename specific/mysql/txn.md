mvcc: row_trx_id for each data row

each txn has an array to keep track of active txn ids when this txn is created

when renew: the data is read first and then update -> this is called current read

CR is the heart of RR, when update, ONLY current read, if current recond's row lock is used, waited

as a comparions, RC will calculate a new view before EVERY statement executes

normal read is CR, uses row txn id and consistency view to verify version's visbility
row-locks uses 2PL, i.e., acquire on need, and release when the txn is over
each data uses the auto-incrementing transaction id as the version, i.e., row_trx_id

HWM: greater than that  means not yet started txn
LWM: less than that  means commited txns
In the middle means not yet started txns


### Intention Locks

For example, a statement such as LOCK TABLES ... WRITE takes an exclusive lock (an X lock) on the specified table. To make locking at multiple granularity levels practical, InnoDB uses intention locks. Intention locks are table-level locks that indicate which type of lock (shared or exclusive) a transaction requires later for a row in a table.

Before a transaction can acquire a shared lock on a row or a table, it must first acquire an intention to share (IS) lock or stronger on the TABLE.

Before a transaction can acquire an exclusive lock on a row in a table, it must first acquire an IX lock on the TABLE.

Intention locks do not block anything except full table requests (for example, LOCK TABLES ... WRITE). The main purpose of intention locks is to show that someone is locking a row, or going to lock a row in the table, BUT IT WILL CONFLICT S AND X locks 

SELECT ... LOCK IN SHARE MODE: always requires IS lock
SELECT ... FOR UPDATE: needs IX lock


### Gap Locks

A gap might span a single index value, multiple index values, or even be empty.

Gap locks in InnoDB are “purely inhibitive”, which means that their only purpose is to prevent other transactions from inserting to the gap.

used only during Repeatable Read  and Serializable isolation level. Note that RR does NOT fully prevent phantom read

e.g., suppose you have index with values 10,11,13, and 20 then the  gap lock (-INF, 10], (10, 11], (11,13].... 

Note that table locks are implemented by gap locks!

### Next-Key Locks

A next-key lock is a combination of a record lock on the index record AND a gap lock on the GAP before the index record. 

InnoDB performs row-level locking in such a way that when it searches or scans a table index, it sets shared or exclusive locks on the index records it encounters. Thus, the row-level locks are actually index-record locks. A next-key lock on an index record also affects the “gap” before that index record. 

Mainly to avoid phatom read,i.e., range returns more results as we go!

Note during the run it IS implemented as a combination of row lock and then gap lock

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


### Why default isolation level to RR?

STATEMENT format binlog replication under read committed has bugs, that is why you need repeatable read

1- delete
2 - insert
2 - commit
1 - commit

because binlog will record insertion first and delete second, so slave has wrong data. GL,i.e., turn on RR, will block the delete due to the gap lock

Or switich to row format, we can go with RC

## gap lock case
S1: select * from t3 where id=22 for update; --assume empty here
S2: select * from t3 where id=23 for update; --assume empty here
S1: insert into t3 values(22) ---waitng for lock here
S2: insert into t3 values(23) -- deadlock detected

if a statement operations on non-key index, mysql will lock this non-key index AND THEN lock the key index. Clustered index's leaves saves the whole row. This is a common source of DL too

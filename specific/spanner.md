At every replica that is a leader, each spanserver implements a lock table to support two-phase-locking based concurrency control and a transaction manager to support distributed transactions. If a transaction involves only one Paxos group (as is the case in single row & single shard transactions), it bypasses the transaction manager. The lock table and Paxos together are enough to do the job here. If a transaction involves more than one Paxos group (as is the case in distributed transactions), those groups’ leaders coordinate to perform two-phase commit. The state of the transaction manager is also modeled as a persistent Paxos group to ensure continued availability.

The most noteworthy innovation in Spanner is that it achieves external consistency, an isolation level even stricter than serializability, by assigning global commit timestamps to all transactions using the TrueTime API. TrueTime is Google’s highly reliable “wall-clock” time tracking service (with a bounded uncertainty of 7ms) that is built on GPS and atomic clocks.

We believe it is better to have application programmers deal with performance problems due to overuse of transactions as bottlenecks arise, rather than always coding around the lack of transactions. Running two-phase commit over Paxos mitigates the availability problems.

 In active/active, the benefit of write scaling is negated by conflict-ridden concurrent writes on same rows at different masters. Such conflicts are resolved without explicit knowledge of the app using non-deterministic heuristics such as Last-Write-Wins (LWW) and Conflict-Free Replicated Data Types (CRDT)


If you declare a table to be a child of another table, the primary key column(s) of the parent table must be the prefix of the primary key of the child table.

1. Hash the key and store it in a column. Use the hash column (or the hash column and the unique key columns together) as the primary key.
You can use the hash value to create logical shards, or partitions, in your database. (In a physically sharded database, the rows are spread across several databases. In a logically sharded database, the shards are defined by the data in the table.) For example, to spread writes to the Users table across N logical shards, you could prepend a ShardId key column to the table

Reading efficiency. Reads are faster if there are fewer splits to scan.

2. Swap the order of the columns in the primary key.
3. Use a Universally Unique Identifier (UUID). Version 4 UUID is recommended, because it uses random values in the high-order bits. Don't use a UUID algorithm (such as version 1 UUID) that stores the timestamp in the high order bits.
4. Bit-reverse sequential values.

 A split is defined as a range of rows in a top-level (in other words, non-interleaved) table, where the rows are ordered by primary key. The start and end keys of this range are called "split boundaries".

 When more rows are appended to the table, the split grows, and when it reaches its maximum size (approximately 4 GB),

 Use descending order for timestamp-based keys: 
* If you're using an interleaved table for the history, and you'll be reading the parent row as well. 
* If you're reading sequential entries in reverse chronological order, and you don't know exactly how far back you're going. 

### Index

because indexes are implemented as tables under the hood, and the resulting index table would use a column whose value monotonically increases as its first key part.

It is okay to create an interleaved index like this though, because rows of interleaved indexes are interleaved in corresponding parent rows, and it's unlikely for a single parent row to produce thousands of events per second.

For SQL queries that use an index directive, Cloud Spanner's SQL query processor might need to read columns that are required by the query but that aren't stored in the index. The query processor retrieves these columns using a join between the index and the base table.

  Cloud Spanner can create approximately 3 non-interleaved indexes per day per database, regardless of the size of the tables being indexed.

Avoid making many schema updates to a single database's schema in a given 7-day period. 

Avoid more than 30 DDL statements that require validation or index backfill in a given 7-day period, because each statement creates multiple versions of the schema internally.

Cloud Spanner buffers insertions, updates, and deletions performed using DML statements on the server-side, and the results are visible to subsequent SQL and DML statements within the same transaction. This behavior is different from the Mutation API, where Cloud Spanner buffers the mutations on the client-side and sends the mutations server-side as part of the commit operation. As a result, mutations in the commit request are not visible to SQL or DML statements within the same transaction.

but it's a best practice to explicitly tell Cloud Spanner to use that index by specifying an index directive in the FROM clause

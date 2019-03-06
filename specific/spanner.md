you can optionally define parent-child relationships between tables if you want Cloud Spanner to physically co-locate their rows for efficient retrieval.

If you declare a table to be a child of another table, the primary key column(s) of the parent table must be the prefix of the primary key of the child table.

Cloud Spanner stores rows in sorted order by primary key values, with child rows inserted between parent rows that share the same primary key prefix. This insertion of child rows between parent rows along the primary key dimension is called interleaving, and child tables are also called interleaved tables.

 For example, if you insert records with a monotonically increasing integer as the key, you'll always insert at the end of your key space. This is undesirable because Cloud Spanner divides data among servers by key ranges, which means your inserts will be directed at a single server, creating a hotspot.


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

    , because indexes are implemented as tables under the hood, and the resulting index table would use a column whose value monotonically increases as its first key part.

    It is okay to create an interleaved index like this though, because rows of interleaved indexes are interleaved in corresponding parent rows, and it's unlikely for a single parent row to produce thousands of events per second.


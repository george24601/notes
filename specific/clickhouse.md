
Replication works at the level of an individual table, not the entire server. A server can store both replicated and non-replicated tables at the same time.

ZooKeeper is not used in SELECT queries because replication does not affect the performance of SELECT and queries run just as fast as they do for non-replicated tables.

Each block of data is written atomically. The INSERT query is divided into blocks up to max_insert_block_size = 1048576 rows. In other words, if the INSERT query has less than 1048576 rows, it is made atomically.

By default, an INSERT query waits for confirmation of writing the data from only one replica. If the data was successfully written to only one replica and the server with this replica ceases to exist, the stored data will be lost. To enable getting confirmation of data writes from multiple replicas, use the insert_quorum option.

Replication is asynchronous and multi-master. INSERT queries (as well as ALTER) can be sent to any available server. Data is inserted on the server where the query is run, and then it is copied to the other servers. Because it is asynchronous, recently inserted data appears on the other replicas with some latency. If part of the replicas are not available, the data is written when they become available. If a replica is available, the latency is the amount of time it takes to transfer the block of compressed data over the network. 

For each INSERT query, approximately ten entries are added to ZooKeeper through several transactions. (To be more precise, this is for each inserted block of data; an INSERT query contains one block or one block per max_insert_block_size = 1048576 rows.) This leads to slightly longer latencies for INSERT compared to non-replicated tables. But if you follow the recommendations to insert data in batches of no more than one INSERT per second, it does not create any problems. The entire ClickHouse cluster used for coordinating one ZooKeeper cluster has a total of several hundred INSERTs per second. 

Replication does not depend on sharding. Each shard has its own independent replication.

The key for partitioning by month allows reading only those data blocks which contain dates from the proper range. In this case, the data block may contain data for many dates (up to an entire month). Within a block, data is sorted by primary key (by default sort key), which might not contain the date as the first column. Because of this, using a query with only a date condition that does not specify the primary key prefix will cause more data to be read than for a single date.

Data belonging to different partitions are separated into different parts. In the background, ClickHouse merges data parts for more efficient storage. Parts belonging to different partitions are not merged. The merge mechanism does not guarantee that all rows with the same primary key will be in the same data part.

When data is inserted in a table, separate data parts are created and each of them is lexicographically sorted by primary key.

By default the primary key is the same as the sorting key (which is specified by the ORDER BY clause). Thus in most cases it is unnecessary to specify a separate PRIMARY KEY clause.

For production usage ReplicatedMergeTree is the way to go, because it adds high-availability to all features of regular MergeTree engine. A bonus is automatic data deduplication on data ingestion, so the software can safely retry if there was some network issue during insert.

The main downside of MergeTree engines is that they are rather heavy-weight. So the typical pattern is to have not so many of them. If you need many small tables, for example for temporary data, consider Log engine family.

fact table is changed much more frequently than dimension tables

primary key is not used to dedup 

sparse index: stats on blocks rather than row

LSM tree: once the data is in hard if not possible to change

delete and update are async, need to see the effect after the compaction

may consider using map in combination with columns 

write local table instead of distributed table
* Too many parts error: distributed table node have to shard and forward.
* distributed table node: many temp data, that caused write amplification

local write has better performance, but need to know all underlying ips

When you write a query in the form of two joined subqueries:

SELECT * FROM (SELECT ... FROM distributed) JOIN (SELECT ... FROM distributed)
data is transferred to initiator node and joined there. So, the JOIN is processed not in distributed fashion and the setting distributed_product_mode does not have any effect.

In contrast, when the left table is not a subquery, the JOIN is performed in distributed fashion:

Engines in the MergeTree family are designed for inserting a very large amount of data into a table. The data is quickly written to the table part by part, 

PARTITION BY — The partitioning key. Optional. In most cases you don't need partition key, and in most other cases you don't need partition key more granular than by months. Partitioning does not speed up queries (in contrast to the ORDER BY expression). You should never use too granular partitioning. Don't partition your data by client identifiers or names (instead make client identifier or name the first column in the ORDER BY expression).

For partitioning by month, use the toYYYYMM(date_column) expression, where date_column is a column with a date of the type Date. The partition names here have the "YYYYMM" format

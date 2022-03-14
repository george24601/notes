fact table is changed much more frequently than dimension tables

lack of delete/update may be an issue, so seems to fit offline analytics better

supports sortby when creating table - they will be stored in consecutive blocks

primary key is not used to dedup 

sparse index: stats on blocks rather than row

LSM tree: once the data is in hard if not possible to change

delete and update are async, need to see the effect after the compaction

alter table delete where filter_expr,alter table update col=val where filter_expr

low qps, limit it to within 100

useful to store user event logs

may consider using map in combination with columns 

write local table instead of distributed table
* Too many parts error: distributed table node have to shard and forward.
* distributed table node: many temp data, that caused write amplification

Code: 252, e.displayText() = DB::Exception: Too many parts (301) . Merges are processing significantly slower than inserts. Because merge is async, too fast insertion may cause that

optimize for throughput rather than latency

optimized for append-only data, and little joins

local write has better performance, but need to know all underlying ips

some companies put mysql in front of the CH still

###

When you write a query in the form of two joined subqueries:

SELECT * FROM (SELECT ... FROM distributed) JOIN (SELECT ... FROM distributed)
data is transferred to initiator node and joined there. So, the JOIN is processed not in distributed fashion and the setting distributed_product_mode does not have any effect.

In contrast, when the left table is not a subquery, the JOIN is performed in distributed fashion:

### Merge tree

Engines in the MergeTree family are designed for inserting a very large amount of data into a table. The data is quickly written to the table part by part, 

Stores data sorted by primary key. This allows you to create a small sparse index that helps find data faster

ClickHouse uses the sorting key as a primary key if the primary key is not defined obviously by the PRIMARY KEY clause.

PARTITION BY — The partitioning key. Optional. In most cases you don't need partition key, and in most other cases you don't need partition key more granular than by months. Partitioning does not speed up queries (in contrast to the ORDER BY expression). You should never use too granular partitioning. Don't partition your data by client identifiers or names (instead make client identifier or name the first column in the ORDER BY expression).
For partitioning by month, use the toYYYYMM(date_column) expression, where date_column is a column with a date of the type Date. The partition names here have the "YYYYMM" format

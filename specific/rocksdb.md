* column family
* LSM - how it works, and pros and cons
* compaction - how does it work?
* how data write works in rocks db
* rocksdb major parametersSnapshot, atomic batch write

First of all, all data in a TiKV node shares two RocksDB instances. One is for data, and the other is for Raft log.

prefix in rocksdb?

max-sub-compactions?

rocksdb compaction?

block cache in rocks db

rocksdb space amplification

write buffer rocksdb

rocksdb background job?

As you can see, we save the key with a timestamp suffix, but can only seek the key without the timestamp, so we set a prefix extractor and enable the memtable bloom filter

The key format for our Raft log saved in RocksDB is: region ID plus log ID, the log ID is monotonically increased.

We record the total data size in the SST table property when doing compaction, get all table properties in the range, then add up the total size.

As you can see, this flow is very slow and can cause high pressure in RocksDB. So now, we use the IngestFile feature instead. At first, we scan the key-values and save them to an SST file, then we ingest the SST file directly.

newest ts goes first, so the first response of seek (note, it is done by inversing the bits of ts)

A column family is a database object that contains columns of related data. It is a tuple (pair) that consists of a key-value pair, where the key is mapped to a value that is a set of columns. In analogy with relational databases, a column family is as a "table", each key-value pair being a "row". Each column is a tuple (triplet) consisting of a column name, a value, and a timestamp. In a relational database table, this data would be grouped together within a table with other non-related data.

Reads are made faster with approaches such as bloom filters (to reduce the number of files to be checked during a point query) and per-SSTable min-max metadata hints (for efficient range queries).

It has a Log-Structured-Merge-Database (LSM) design with flexible tradeoffs between Write-Amplification-Factor (WAF), Read-Amplification-Factor (RAF) and Space-Amplification-Factor (SAF). It has multi-threaded compactions, making it especially suitable for storing multiple terabytes of data in a single database

A rocksdb database has a name which corresponds to a file system directory. All of the contents of database are stored in this directory

The three basic constructs of RocksDB are memtable, sstfile and logfile. The memtable is an in-memory data structure - new writes are inserted into the memtable and are optionally written to the logfile. The logfile is a sequentially-written file on storage. When the memtable fills up, it is flushed to a sstfile on storage and the corresponding logfile can be safely deleted. The data in an sstfile is sorted to facilitate easy lookup of keys.

 It also supports atomic cross-column family operations via the WriteBatch API.

 A Write API allows multiple keys-values to be atomically inserted, updated, or deleted in the database.

 A consistent-point-in-time view of the database is created when the Iterator is created. Thus, all keys returned via the Iterator are from a consistent view of the database.

 An iterator keeps a reference count on all underlying files that correspond to that point-in-time-view of the database - these files are not deleted until the Iterator is released. A snapshot, on the other hand, does not prevent file deletions; instead the compaction process understands the existence of snapshots and promises never to delete a key that is visible in any existing snapshot.

 Most LSM-tree engines cannot support an efficient RangeScan API because it needs to look into multiple data files. But most applications do not do pure-random scans of key ranges in the database; instead applications typically scan within a key-prefix. RocksDB uses this to its advantage. Applications can configure a prefix_extractor to specify a key-prefix. RocksDB uses this to store blooms for every key-prefix. An iterator that specifies a prefix (via ReadOptions) will use these bloom bits to avoid looking into data files that do not contain keys with the specified key-prefix.

 These checksums are for each SST file block (typically between 4K to 128K in size). A block, once written to storage, is never modified.

 The entire database is stored in a set of sstfiles. When a memtable is full, its content is written out to a file in Level-0 (L0). RocksDB removes duplicate and overwritten keys in the memtable when it is flushed to a file in L0. Some files are periodically read in and merged to form larger files - this is called compaction

 The overall write throughput of an LSM database directly depends on the speed at which compactions can occur, especially when the data is stored in fast storage like SSD or RAM. RocksDB may be configured to issue concurrent compaction requests from multiple threads. It is observed that sustained write rates may increase by as much as a factor of 10 with multi-threaded compaction when the database is on SSDs

A MANIFEST file in the database records the database state. The compaction process adds new files and deletes existing files from the database, and it makes these operations persistent by recording them in the MANIFEST file.

Background compaction threads are also used to flush memtable contents to a file on storage. If all background compaction threads are busy doing long-running compactions, then a sudden burst of writes can fill up the memtable(s) quickly, thus stalling new writes. This situation can be avoided by configuring RocksDB to keep a small set of threads explicitly reserved for the sole purpose of flushing memtable to storage.

The default implementation of the memtable for RocksDB is a skiplist. The skiplist is a sorted set, which is a necessary construct when the workload interleaves writes with range-scans.

RocksDB supports configuring an arbitrary number of memtables for a database. When a memtable is full, it becomes an immutable memtable and a background thread starts flushing its contents to storage. Meanwhile, new writes continue to accumulate to a newly allocated memtable. If the newly allocated memtable is filled up to its limit, it is also converted to an immutable memtable and is inserted into the flush pipeline.

BlockBasedTable is the default SST table format in RocksDB.

PlainTable is a RocksDB's SST file format optimized for low query latency on pure-memory or really low-latency media.o



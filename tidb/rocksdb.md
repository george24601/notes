cf_options.write_buffer_size = 64, It represents the amount of data to build up in memory (backed by an unsorted log on disk) before converting to a sorted on-disk file. The default is 64 MB; 

Block Cache Size: We recommend that this should be about 1/3 of your total memory budget. The remaining free memory can be left for the OS (Operating System) page cache. Leaving a large chunk of memory for OS page cache has the benefit of avoiding tight memory budgeting

cf_options.compression controls the compression type used for the first n-1 levels. We recommend to use LZ4 (kLZ4Compression), or if not available, to use Snappy (kSnappyCompression).

cf_options.bottommost_compression controls the compression type used for the nth level. We recommend to use ZStandard (kZSTD), or if not available, to use Zlib (kZlibCompression).

It can be a good idea to limit the rate of compactions and flushes to smooth I/O operations, one reason for doing this is to avoid the read latency outliers. This can be done by means of the db_options.rate_limiter option

max-background-jobs: default 8

We record the total data size in the SST table property when doing compaction, get all table properties in the range, then add up the total size.

Reads are made faster with approaches such as bloom filters (to reduce the number of files to be checked during a point query) and per-SSTable min-max metadata hints (for efficient range queries).

A rocksdb database has a name which corresponds to a file system directory. All of the contents of database are stored in this directory

 It also supports atomic cross-column family operations via the WriteBatch API.

 A Write API allows multiple keys-values to be atomically inserted, updated, or deleted in the database.

 A consistent-point-in-time view of the database is created when the Iterator is created. Thus, all keys returned via the Iterator are from a consistent view of the database.

 An iterator keeps a reference count on all underlying files that correspond to that point-in-time-view of the database - these files are not deleted until the Iterator is released. A snapshot, on the other hand, does not prevent file deletions; instead the compaction process understands the existence of snapshots and promises never to delete a key that is visible in any existing snapshot.

 These checksums are for each SST file block (typically between 4K to 128K in size). A block, once written to storage, is never modified.

A MANIFEST file in the database records the database state. The compaction process adds new files and deletes existing files from the database, and it makes these operations persistent by recording them in the MANIFEST file.

The default implementation of the memtable for RocksDB is a skiplist. The skiplist is a sorted set, which is a necessary construct when the workload interleaves writes with range-scans.

RocksDB supports configuring an arbitrary number of memtables for a database. When a memtable is full, it becomes an immutable memtable and a background thread starts flushing its contents to storage. Meanwhile, new writes continue to accumulate to a newly allocated memtable. If the newly allocated memtable is filled up to its limit, it is also converted to an immutable memtable and is inserted into the flush pipeline.

BlockBasedTable is the default SST table format in RocksDB.

PlainTable is a RocksDB's SST file format optimized for low query latency on pure-memory or really low-latency media.o

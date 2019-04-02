B-Trees usually grow wide and shallow, so for most queries very few nodes need to be traversed. Net result is high throughput, low latency reads. However, the need to maintain a well-ordered data structure with random writes usually leads to poor write performance. This is because random writes to the storage are more expensive than sequential writes. Also, a minor update to a row in a block requires a read-modify-write penalty of an entire block.

LSM trees use an algorithm that defers and batches index changes, cascading the changes from a memory-based component (C0 in the above picture) through one or more disk components (C1 to CL) in an efficient manner reminiscent of merge sort. Note that random writes at the in-memory C0 component are turned into sequential writes at the disk-based C1 component.

The primary reason behind their success is their ability to do fast sequential writes (as opposed to slow random writes in B-Tree engines) especially on modern flash-based SSDs that are inherently better suited for sequential access.

 Reads are made faster with approaches such as bloom filters (to reduce the number of files to be checked during a point query) and per-SSTable min-max metadata hints (for efficient range queries).


 It adds cross-shard ACID transactions using a two-phase commit protocol on top of BigTable’s single row atomicity. This enhancement was necessary because the process of updating an index is now divided into multiple concurrent transactions, each of which has to preserve invariants such as the highest PageRank URL has to be always present in the index and link inversion to anchor text should work across duplicates.

 Percolator provides Snapshot Isolation, implemented using MVCC and a monotonically increasing timestamp allocated by a Timestamp Oracle. Every transaction requires contacting this Oracle twice, thus making the scalability and availability of this component a significant concern.

  it’s design is not suitable for an OLTP database where user-facing transactions have to be processed with low latency.

  Relaxed latency requirements let us take, for example, a lazy approach to cleaning up locks left behind by transactions running on failed machines. This lazy, simple-to-implement approach potentially delays transaction commit by tens of seconds. This delay would not be acceptable in a DBMS running OLTP tasks, but it is tolerable in an incremental processing system building an index of the web. Percolator has no central location for transaction management; in particular, it lacks a global deadlock detector. This increases the latency of conflicting transactions but allows the system to scale to thousands of machines.

TiDB, a MySQL-compatible distributed database, uses Percolator as the inspiration for its distributed transaction design. This choice makes sense given TiDB’s focus on throughput-oriented Hybrid Transactional/Analytical Processing (HTAP) use cases that are not latency sensitive and usually run in a single datacenter

Percolator’s primary limitation is the lack of multi-region distributed transactions with low latency. Such transactions are absolutely necessary to power geo-distributed OLTP workloads (think Gmail, Calendar, AdWords, Google Play and more).

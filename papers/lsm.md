RocksDB: Snapshot, atomic batch write

B+ has problem with random reads ->
LSM tree , memory table -> immutable memory table -> SST with compaction
write magnifying problem: SST compaction mean multiple writes

B-Trees usually grow wide and shallow, so for most queries very few nodes need to be traversed. Net result is high throughput, low latency reads. However, the need to maintain a well-ordered data structure with random writes usually leads to poor write performance. This is because random writes to the storage are more expensive than sequential writes. Also, a minor update to a row in a block requires a read-modify-write penalty of an entire block.

LSM trees use an algorithm that defers and batches index changes, cascading the changes from a memory-based component (C0 in the above picture) through one or more disk components (C1 to CL) in an efficient manner reminiscent of merge sort. Note that random writes at the in-memory C0 component are turned into sequential writes at the disk-based C1 component.

The primary reason behind their success is their ability to do fast sequential writes (as opposed to slow random writes in B-Tree engines) especially on modern flash-based SSDs that are inherently better suited for sequential access.

 Reads are made faster with approaches such as bloom filters (to reduce the number of files to be checked during a point query) and per-SSTable min-max metadata hints (for efficient range queries).



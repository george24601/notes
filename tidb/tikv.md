Each TiKV contains two RocksDB instances. One of them is used to store Raft Log, which we call Raft RocksDB, and the other is to store the actual data, which we call KV RocksDB.

A TiKV store contains multiple Regions. In Raft RocksDB, we use the Region ID as the prefix of the key, which is combined with Raft Log ID to uniquely identify a Raft Log

RocksDB supports column families, so it can directly correspond to the column families in Percolator. In TiKV, we use the Default CF in RocksDB to directly correspond to the Data CF in Percolator, and use Lock and Write CFs of the same name.

Use big-endian to convert the timestamp to a 8-byte value, and then invert the bytes by bit.
Combine the inverted bytes with the original key for storage in RocksDB

(small data case) For TiKV, the Lock CF will be read during the Commit phase to determine transaction conflicts, so we can get data from the Lock CF and write it to the Write CF.

Because PK is unique, we can use t + Table ID + PK to uniquely represent a row of data, and the value is this row of data. For the unique index, we use i + Index ID + name to represent it, and the value is the corresponding PK

For the ordinary index, we use i + Index ID + age + PK because no uniqueness constraint is required. The value is empty. Because the PK must be unique, even if the two rows of data have the same age, they will not conflict. To query with the ordinary index, TiKV seeks the data with the first key that is greater than or equal to the i + Index ID + age key, and then see if the prefix matches. If the prefix matches, TiKV decodes the corresponding PK, and get the actual data through it.




1. check if the row is locked by checking is meta-key,wait until the lock is released or timeout, or try clearing an already cleared lock
2. read the meta-key, find the t <= startTS, and read at version t

If the table has no PRIMARY KEY or suitable UNIQUE index, InnoDB internally generates a hidden clustered index named GEN_CLUST_INDEX on a synthetic column containing row ID values. The rows are ordered by the ID that InnoDB assigns to the rows in such a table. The row ID is a 6-byte field that increases monotonically as new rows are inserted. Thus, the rows ordered by the row ID are physically in insertion order.

By definition, each table has only 1 clusted index

non-cluster index's leaf is not row, instead, still points to the cluster index's B+ tree, i.e., normal idnex stores the PK, on search, it will normal index to find PK, and use PK to find the row

InnoDB doesn't support hash index, but any part related to sort/range, it is messed up

B tree: 
* both leaves and non-leaves store the data 
* normally a page is 4KB in OS, mysql seems to be 16k - can set node size to page size to take advantage of pre-read
* for each node, # of keys j,  m/2 <= j <= m, where m is the # of branchs

B+ tree:
* non-leaves no longer store the data
* linked list between lieaves -> range search easier 
* leaves goes to disk, non-leaves good for memeory


InnoDB's Btree has about 1.2k children for each node

Non key index will return the ID, and then use the primary index to get the actual row

Try to order by index to avoid the relative expensive sort buffer inside memory

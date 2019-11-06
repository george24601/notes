the buffer pool is implemented as a linked list of pages; data that is rarely used is aged out of the cache using a variation of the LRU algorithm.

When room is needed to add a new page to the buffer pool, the least recently used page is evicted and a new page is added to the middle of the list. This midpoint insertion strategy treats the list as two sublists:

At the head, a sublist of new (“young”) pages that were accessed recently (5/8)

At the tail, a sublist of old pages that were accessed less recently (3/8)

The midpoint of the list is the boundary where the tail of the new sublist meets the head of the old sublist.

Accessing a page in the old sublist makes it “young”, moving it to the head of the new sublist.

The change buffer is a special data structure that caches changes to secondary index pages when those pages are not in the buffer pool. The buffered changes, which may result from INSERT, UPDATE, or DELETE operations (DML), are merged later when the pages are loaded into the buffer pool by other read operations.

Note that Aurora does not support:
* innodb_log_buffer_size
* innodb_log_file_size



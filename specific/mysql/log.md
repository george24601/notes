inno db redo log is a separate thing, not same as the binlog. redo log is used mostly for crash-safe


On update
1. store the pdate in memory
2. write it to the redo log, at prepared state
3. write binlog to disk
4. change the redo log to commited state, i.e. redo log and binlog updates are done in 2PC


Our current state is checkpoint_age, which is the age of the oldest modified non-flushed page

When checkpoint_age reaches “async”, InnoDB tries to flush as many pages as possible, while still allowing other queries. You can see the effect from this on the graph in my previous post, when throughput drops down to the floor. The “sync” stage is even worse. When we reach “sync”, InnoDB blocks other queries while trying to flush pages and return checkpoint_age to a point before “async”. This is done to prevent checkpoint_age from exceeding innodb_log_file_size. These are both abnormal operational stages for InnoDB and should be avoided at all cost. In current versions of InnoDB, the “sync” point is at about 7/8 of innodb_log_file_size, and the “async” point is at about 6/8 = 3/4 of innodb_log_file_size.



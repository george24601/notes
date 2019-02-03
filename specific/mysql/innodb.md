inno db redo log is a separate thing, not same as the binlog. redo log is used mostly for crash-safe

On update
1. store the pdate in memory
2. write it to the redo log, at prepared state
3. write binlog to disk
4. change the redo log to commited state, i.e. redo log and binlog updates are done in 2PC


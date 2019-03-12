inno db redo log is a separate thing, not same as the binlog. redo log is used mostly for crash-safe

On update
1. store the pdate in memory
2. write it to the redo log, at prepared state
3. write binlog to disk
4. change the redo log to commited state, i.e. redo log and binlog updates are done in 2PC

When table data is cached in the InnoDB buffer pool, it can be accessed repeatedly by queries without requiring any disk I/O. Specify the size of the buffer pool with the innodb_buffer_pool_size option. This memory area is important enough that it is typically recommended that innodb_buffer_pool_size is configured to 50 to 75 percent of system memory.

When an application (MySQL, or other specific application running in the user space) executes a read system call, page cache (write-back cacheimplemented in the OS kernel inside the system space) is looked at first. If the data is in page cache, then it’s copied out into the buffers (memory area) in the application address space. Otherwise, it’s loaded from persistent storage (disk) into page cache for further accesses, as well as copied out into the application space.

When an application executes a write system call, the data moves from the buffers in the application address space into page cache. and the underlying page (every piece of data lives inside a logical box called a page) gets marked as a dirty page. In order to synchronize dirty pages with the storage, a background process called write-back flushes them to the storage and evicts them from the page cache some time afterward.

Using this mechanism, the data file is mapped into the process address space (MySQL process) using the mmap system call. Read/write operations are performed by directly accessing the address space. In this way, an extra step is eliminated while accessing the data. So, there is no need for intermediate buffers in the user space because every buffer cache is in the system space implemented as page cache by the kernel.

If the data is in page cache, the kernel is bypassed and read operations are performed at memory speed. If the data is not in page cache, a page-fault is issued and the kernel looks for the data for that page and loads the data in page cache to be accessible to the application.

It’s very common for database engines to use this mechanism to access data files.

By default, the write system call returns after all data has been copied from the user space into page cache in the system space. There is no guarantee that data has actually reached storage.

To support this scenario, the sync system call is used to be sure the data is actually transferred from page cache into storage.

The sync system call allows a process to flush all buffers to disk while the fsync system call allows a process to flush the buffers specific to an open file.

The parameter innodb_flush_method allows tuning the IO scheduling

Empty: This is the default value, and is equivalent to using the FSYNC option (see below)

InnoDB works with data in memory, and all changes to data are performed in memory. In order to survive a crash or system failure, InnoDB is logging changes into InnoDB transaction logs. The size of the InnoDB transaction log defines how many changed blocks we can have in memory for a given period of time.

The obvious question is: Why can’t we simply have a gigantic InnoDB transaction log? The answer is that the size of the transaction log affects recovery time after a crash. The bigger the log, the longer the recovery time.

ur current state is checkpoint_age, which is the age of the oldest modified non-flushed page. Checkpoint_age is located somewhere between 0 and innodb_log_file_size. Point 0 means there are no modified pages. Checkpoint_age can’t grow past innodb_log_file_size, as that would mean we would not be able to recover after a crash.

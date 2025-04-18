Spring's TaskExecutor = java.util.concurrent.Executor, it is original goal is to provide threadpool abstraction to other Spring component, e.g., ApplicationEventMulticaster

* SimpleAsyncTaskExecutor - just spawn a new thread, supports #s of concurrent threads
* SyncTaskExecutor - inside the caller's thread, mainly used for test case
* ConcurrentTaskExecutor - backup choice ThreadPollTaskExecutor
* ThreadPoolTaskExecutor - can NOT use it the place of java.util.concurrent. Common!

### ThreadPoolTaskExecutor
* corePoolSize 
* maximumPoolSize
* keepAliaveTime (for each thread)
* BlockingQueue<Runnable> workQueue
* RejectedExecutionHandler handler 
  * when TP is full or thread not at running state, i.e., that is the one that throws o.s.c.t.TaskRejectedException
  * ThreadPoolExecutor.AbortPolicy()


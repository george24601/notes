Not recommend to create via Executors static Factory, instead, use ThreadPoolExecutor 
acc
corePoolSize
maximumPoolSzie
workQueue
keepAliveTime
threadFactory
handler

On execute() 
1. if # of threads < corePoolSize, execute addWorker, 
2. if TP is running, if so, can you insert into the task queue? after insertion, double check if TP is running, if so, create a new thread, otherwise, remove the inserted task
3. if failed to add non-core thread, just reject  

On addWorker()
1. if the TP status >= SHUTDOWN, do nothing, just return
2. self-spin to check if the one we created is core thread, if so and current number < size, break from the loop and start creating the new thread
3. break retry and continue retry???
4. acquire the main lock for TP, add thread to workers, start the new thread
5. workers is a hashset

On runWorker(Worker w): 
1. if it is first time to exec or can get task from the queue
2. after acquiring the task, preexecute
3. execute
4. postexecute



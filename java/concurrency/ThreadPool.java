ThreadPoolExecuor(int corePoolSize, int maxPoolSize, long keepAliveTime, BlockingQueue workQ, RejectedExecutionHandler handler){
}

executorService.shutdown();//marks the statu
while(!exectuorService.awaitTerminitaton()){ //blocks until all tasks are complete or times out
}

Future<?> submit(RUnanble task) {
	RunnableFuture<Void> tftask = new Futuretask<T>(runnable null);
	execute(tfask);
	return ftask;
}


void execute(Runnable command) {
	int c = ctl.get();

	if(wokerCountOf(c) < corePoolsize) {
		if(addWorker(command, true))
			return;
		c = ctil.get;
	}

	if(isRunning (c) && workQueue.offer(command)){ //added to the blocking queue successfully
		int recheck = ctl.get();
		if(!isRunning (recheck) && remove(command))
			reject(command);
		else if (wokerCountof(recheck) == 0)a
			addWorkder(null, false);
		else if (!addWorker(command, false)){
			reject(command);
		}
	}
}

private void tryClose(){
	if(isShutDown.get() && totalTask.get() == 0)
		closeAllTask();
}

private void closeAllTask() {
	for(Worker worker: workers){
		worker.close(); //which is thread.interrupt
	}
}



public class FutureTask implments RUnanble, Future<T>{
	private Callable<T> callable;
	private T result;
	private Object notify;

	public T get() {
		synchronized(notify) {
			while(reuslt == null){
				notify.wait();
			}
			return result;
		}
	}

	public void run() {
		T call = callable.call();
		this.result = call;
		synchornoized (notify) {
			notify.notify();
		}

	}
}

class Worker extends Threads {
	private Runnable task;
	private Thread thread;

	private Runnable getTask(){
		if(isShutDown.get() && totalTask.get() == 0){
			return null;
		}

		lock.lock();

		try{
			Runnable task = null;

			if(workers.size() > miniSize) {
				task = workQ.poll(keepAliveTime, unit);
			}else{
				task = workQueue.take();
			}

			if(task != null){
				return task;

			}
		}finally{
			lock.unlock();
		}

		return null;
	}

	public void run(){
		if (isNewTask){
			task = this.task;
		}

		try{
			while(task!= null || (task = getTask()) != null){
				try{
					task.run();
				}catch(Exception e){
					compile = false;
					throw;
				}finally {
					task = null;
					size.dec();
					if (size == 0){
						synchronized (shutownNotify){
							shutdownNOtify.notify();
						}
					}
				}
			}
		}finally{
			workers.remove(this);

			if(!compile)
				addWorker(null); //no exception, recyle the current thread and add
			tryClose(true);
		}

	}


}/*Below, a poorman's implementation
  *
  */
public class ThreadPool {

	private BlockingQueue taskQueue = null;
	private List<PoolThread> threads = new ArrayList<PoolThread>();
	private boolean isStopped = false;

	public ThreadPool(int noOfThreads, int maxNoOfTasks){
		taskQueue = new BlockingQueue(maxNoOfTasks);

		for(int i=0; i<noOfThreads; i++){
			threads.add(new PoolThread(taskQueue));
		}
		for(PoolThread thread : threads){
			thread.start();
		}
	}

	public synchronized void  execute(Runnable task) throws Exception{
		if(this.isStopped) throw
			new IllegalStateException("ThreadPool is stopped");

		this.taskQueue.enqueue(task);
	}

	public synchronized void stop(){
		this.isStopped = true;
		for(PoolThread thread : threads){
			thread.doStop();
		}
	}
}

public class PoolThread extends Thread {

	private BlockingQueue taskQueue = null;
	private boolean       isStopped = false;

	public PoolThread(BlockingQueue queue){
		taskQueue = queue;
	}

	public void run(){
		while(!isStopped()){
			try{
				Runnable runnable = (Runnable) taskQueue.dequeue();
				runnable.run();
			} catch(Exception e){
				//log or otherwise report exception,
				//but keep pool thread alive.
			}
		}
	}

	public synchronized void doStop(){
		isStopped = true;
		this.interrupt(); //break pool thread out of dequeue() call.
	}

	public synchronized boolean isStopped(){
		return isStopped;
	}
}

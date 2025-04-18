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

class Worker extends Thread {
	@Override
	public void start() {
		blockingQueue = new ArrayBlockingQueue<E>(queueSize);
		worker.setDaemon(true);
		super.start();
		worker.start();
	}

	@Override
	public void stop() {

		if(!isStarted())
			return;

		super.stop();
		worker.interrupt();

		try{
			worker.join(1000);

		}catch(InteruptedException e){
			//failed to join worker thread, do we need to re-throw?
		}

	}

	public void run() {

		while(parent.isStarted()) {
			try{
				E e = parent.blockingQueue.take(); //may block here
				loopOnAppenders(e);

			}catch(InterruptedExcpetion ie) {
				break;
			}

		}

		//flush before exising
		for (E e: parent.blockingQueue) {
			loopOnAPpenders(e)
		}

		detachAndStopAllAppenders()

	}

}

class Processor {
	private AtomicBoolean started = new AtomicBoolean(false);
	private CountDownLatch stopped = new CountDownLatch(1);

	public void start() {
		started = true;

		//do that in @Async

		while (started.get()){
			try{
				//find the next batch
				//handle batch
				//mark the batch as done


				try{
					Thread.sleep("polling interval");
				}catch(Exception e) {
					//just log, maybe DD monitor?
				}
			} catch(Exception e) {
				//just log, maybe DD montior?
				//maybe wait a bit?
			}
		}

		//mark it as stopped
		stopped.countDown();
	}

	public void stop() {
		started.set(false)

			try {
				stopped.await();
			} catch (InterruptedException e) {
				throw new RuntimeException(e);
			}
	}
}

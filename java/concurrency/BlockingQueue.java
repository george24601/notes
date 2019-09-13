public class BlockingQueue {

	private List queue = new LinkedList();
	private int  limit = 10;

	public BlockingQueue(int limit){
		this.limit = limit;
	}


	public synchronized void enqueue(Object item)
			throws InterruptedException  {
			while(this.queue.size() == this.limit) {
				wait();
			}
			if(this.queue.size() == 0) {
				notifyAll();
			}
			this.queue.add(item);
	}


	public synchronized Object dequeue()
			throws InterruptedException{
			while(this.queue.size() == 0){
				wait();
			}
			if(this.queue.size() == this.limit){
				notifyAll();
			}

			return this.queue.remove(0);
	}

}

class ABQ{
	public void put(E e){
		lokc.lockIterrtibly();
		try{
			while(count == items.length)
				notFull.wait();
			enq(e)
		}finally{
			lock.unlock()
		}
	}

	public void enq(E e){
		items[putI ] e;
		putI++;
		if(putI == items.length)
			putI = 0;
		count++;
		notEmpty.signal();
	}

	public E take(){
		lock.lock();
		try{
			while(coutn == 0)
				notEmpty.wait();
			return deq();

		}finally{
			lock.release();

		}

	}

	public E deq() {
		E x = (E) items[takeIndex];
		items[takeI] = null;
		takeIndex++;
		if(takeIndex == items.length)
			takeIndex = 0;
		count--;
		notFull.signal();

		return x;
	}

}

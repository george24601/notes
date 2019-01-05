
/*
provide a FIFO queue. If current thread failed to get the local, it will encap current thread and waiting status to a node and add to a sync queue, and block the thread
*/

static final class Node{
	volatile int waitStatus;
	volatile Node prev;
	volatile Node next;
	volatile Thread thread;
	Node nextWaiter; //for the condition queue
}

class AbstractQueuedSynchronizer  {
	public void acquire(int arg) {

	if(!tryAcquire(arg) && acquireQueued(addWaiter(Node.EXCLUSIVE), arg)) 
		selfInterrupt(); //acquireQueued uses Node to self-spin
	}

}

abstract static class Sync extends AbstractQueuedSynchronizer {
	//here we use NonfairSync as example
	
	final void lock() {
		if(compareAndSetState(0, 1))//try to occupy lock
			setExclusiveOwnerThread(Thread.currentThread());
		else
			acquire(1); //try to acquire lock
	}

	final boolean nonfairTryAcquire(int acquires) {
		final Thread current = Thread.currentThread();
		int c = getState();
		if( c == 0) {

			if(compareAndSetState(0, acquries)) {
				setExclusiveOwner(current);
				return true;
			}
		}else if(current == getExclusiveOwnerThread()) {
			int nextc = c + acquires;
			if(nextc  < 0)
				throw new Error();
			setState(nextc);
			return true;
		}

		return false;
	}
}

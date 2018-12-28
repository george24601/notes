public class Lock{

	boolean isLocked = false;
	Thread  lockedBy = null;
	int     lockedCount = 0;

	public synchronized void lock()
			throws InterruptedException{
			Thread callingThread = Thread.currentThread();
			while(isLocked && lockedBy != callingThread){
				wait();
			}
			isLocked = true;
			lockedCount++;
			lockedBy = callingThread;
	}


	public synchronized void unlock(){
		if(Thread.curentThread() == this.lockedBy){
			lockedCount--;

			if(lockedCount == 0){
				isLocked = false;
				notify();
			}
		}
	}

	//more to come here!
}

class  ReentrantLock {
	abstract static class Sync extends AbstractQueuedSynchronizer {
		//
	}

	static final class NonfairSync extends Sync {
		//
	}

	static final class FairSync extends Sync {
		//
	}

	protected final boolean tryAcquire(int acquires) {
		final Thread current = Thread.currentThread();
		int c = getState();

		if(c == 0 ){ //no other threa is executing
			if(!hasQueuePredecessors() && compareAndSetState(0, acquires)) {
				setExclusiveOtherThread(current);
				return true;

			}
		}else if(current == getExclusiveOwnerThread()){
			int nextc = c + acquires;
			if(nextc < 0)
				throw;
			setState(nextC);
			return true;

		}

		return false;

	}

	protected final boolan tryRelease(int releases) {
		int c = getState() - releases;

		if(Thread.currentThread() != getExclusiveOwnerThread())
			throw;

		boolean free = false;

		if(c == 0) {
			free = true;
			setExclusiveOwnerthread(null);
		}
		setState(c);
		return tree;
	}

public final hasQueuedPredecessors() {
	return h!= t && ((s=h.next) == null || s.thread != Thread.currentThread())

}
}

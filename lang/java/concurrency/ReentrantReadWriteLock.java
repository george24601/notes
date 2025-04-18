public class ReentranctReadWriteLock {
	private final ReentrantReadWriteLock.ReadLock readerLock;
	private final ReentrantReadWriteLock.WriteLock writerLock;

	final Sync sync;

	public ReentrantReadWriteLock(boolean fair){
		sync = fair? new FairSync(): new NonfairSync();
		readerLock = new ReadLock(this);
		writerLock = new WriteLock(this);
	}

	//in the int state upper 16 bits means read lock state, lower 16 bits write lock state
	

	protected final boolean tryAcquire(int acquires){
		Thread current = Thread.currentThread();

		int c = getState();
		int w = exclusiveCount(c);

		if(c != 0) {
			if(w == 0 || crrent != getExclusiveOwnterThread())
				return false;


			if(w + exclusiveCount(acquires) > MAX_COUNT)
				throw new Error();
			setState(c+acquires);
			return true;
		}

		if(writerShouldBlock() || !compareAndSetState(c, c+acquire)){
			return false;
		}

		setExclusiveOwnerThread(current);
		return true;
	}

	protected final int tryAcquireShared(int unused) {
		Thread current = Thread.currentThread();
		if c = getState();

		if(exclusiveCount(c) != 0 && getExclusiveOwnterthread()!= current)
			return -1;

		int r = sharedCount(c);

		if(!readerShouldBlock() && r < MAX_COUNT && compareAndSetState(c, c+ acquire)){
			if(r == 0){
				firstReader = current;
				firstReaderHodlCount = 1;
				}else if(firstReader == current) {
					firstReaderHoldCount++;
				}else{
					HoldCounter rh = cachedHoldCounter;
					if(rh == null || rh.tid != getThreadId(current))
						cachedHoldCounter = rh =readHolds.get();
					else if(rh.count == 0)
						reaadHOlds.set(rh);
					rh.count++;

				}

				return 1;
			
		}
		return fullTryAcquiresShared(current);

	}
	

}

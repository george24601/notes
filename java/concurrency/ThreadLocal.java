class ThreadLocal {
	void createMap(Thread t, T firstValue) {
		t.threadLocals = new ThreadLocalMap(this, firstValue);
	}

	ThreadLocalMap getMap(Thread t) {
		return t.threadLocals;
	}

	public void set(T value) {
		Thread t = Thread.currentThread();
		ThreadLocalMap map = getMap(t);
		if (map != null)
			map.set(this, value);
		else
			createMap(t, value);
	}

	protected T initialValue() {
		return null;
	}

	private T setInitialValue() {
		T value = initialValue();
		Thread t = Thread.currentThread();
		ThreadLocalMap map = getMap(t);
		if (map != null)
			map.set(this, value);
		else
			createMap(t, value);
		return value;
	}

	public T get() {
		Thread t = Thread.currentThread();

		ThreadLocalMap map = getMap(t);
		if (map != null) {
			ThreadLocalMap.Entry e = map.getEntry(this);
			if (e != null) {
				@SuppressWarnings("unchecked")
				T result = (T)e.value;
				return result;
			}
		}

		return setInitialValue();
	}

	public void remove() {
		ThreadLocalMap m = getMap(Thread.currentThread());
		if (m != null)
			m.remove(this);
	}
}



class ThreadLocalMap {

	private Entry[] table;

	private static final int INITIAL_CAPACITY = 16;

	private void setThreshold(int len) {
		threshold = len * 2 / 3;
	}

	ThreadLocalMap(ThreadLocal<?> firstKey, Object firstValue) {
		table = new Entry[INITIAL_CAPACITY];
		int i = firstKey.threadLocalHashCode & (INITIAL_CAPACITY - 1);
		table[i] = new Entry(firstKey, firstValue);
		size = 1;
		setThreshold(INITIAL_CAPACITY);
	}

	private static int nextHashCode() {
		return nextHashCode.getAndAdd(HASH_INCREMENT);
	}

	private Entry getEntryAfterMiss(ThreadLocal<?> key, int i, Entry e) {
		Entry[] tab = table;
		int len = tab.length;

		while (e != null) {
			ThreadLocal<?> k = e.get();
			if (k == key)
				return e;
			if (k == null)
				expungeStaleEntry(i);
			else
				i = nextIndex(i, len);
			e = tab[i];
		}
		return null;
	}

	private int expungeStaleEntry(int staleSlot) {
		Entry[] tab = table;
		int len = tab.length;

		// expunge entry at staleSlot
		tab[staleSlot].value = null;
		tab[staleSlot] = null;
		size--;

		// Rehash until we encounter null
		Entry e;
		int i;
		for (i = nextIndex(staleSlot, len); (e = tab[i]) != null; i = nextIndex(i, len)) {
			ThreadLocal<?> k = e.get();
			if (k == null) {
				e.value = null;
				tab[i] = null;
				size--;
			} else {
				int h = k.threadLocalHashCode & (len - 1);
				if (h != i) {
					tab[i] = null;

					// Unlike Knuth 6.4 Algorithm R, we must scan until
					// null because multiple entries could have been stale.
					while (tab[h] != null)
						h = nextIndex(h, len);
					tab[h] = e;
				}
			}
		}
		return i;
	}

	private boolean cleanSomeSlots(int i, int n) {
		boolean removed = false;
		Entry[] tab = table;
		int len = tab.length;
		do {
			i = nextIndex(i, len);
			Entry e = tab[i];
			if (e != null && e.get() == null) {
				n = len;
				removed = true;
				i = expungeStaleEntry(i);
			}
		} while ( (n >>>= 1) != 0);
		return removed;
	}

	private void set(ThreadLocal<?> key, Object value) {

		Entry[] tab = table;
		int len = tab.length;
		int i = key.threadLocalHashCode & (len-1);

		for (Entry e = tab[i]; e != null; e = tab[i = nextIndex(i, len)]) {
			ThreadLocal<?> k = e.get();
			if (k == key) {
				e.value = value;
				return;
			}
			if (k == null) {
				replaceStaleEntry(key, value, i);
				return;
			}
		}
		tab[i] = new Entry(key, value);
		int sz = ++size;

		//clean up stale entry to prevent memory leak
		if (!cleanSomeSlots(i, sz) && sz >= threshold)
			rehash();
	}

}

//threadRef->currentThread->threadLocalMap->entry->valueRef->valueMemory , if the thread terminates, we are good
//however, if the it is threadpooled, the thread never terminates -> we got problem!

static class Entry extends WeakReference<ThreadLocal<?>> {
	/** The value associated with this ThreadLocal. */
	Object value;

	Entry(ThreadLocal<?> k, Object v) {
		super(k);
		value = v;
	}
}


class TLEx {

private ThreadLocal<String> myThreadLocal = new ThreadLocal<String>();

void run() { 
myThreadLocal.set("Hello ThreadLocal");
String threadLocalValue = myThreadLocal.get();
}

}

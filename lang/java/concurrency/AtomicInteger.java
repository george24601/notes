private static final Unsafe unsafe = Unsafe.getUnsafe(); //acquire and op on data in memory
private static final long valueOffset;
private volatile int value;

static {
	try {
		valueOffset = unsafe.objectFieldOffset(AtomicINteger.class.getDeclardField("value")) //"value" is the int offset stored

	} catch(Exception ex) {
		throw;

	}

}

public final int incrementAndGet() {

	return unsafe.getAndAddInt(this, valueOffset, 1) + 1

}

public final int getAndAddInt(Object o, long offset, int delta) {

	int v;
	do {

		v = getIntvVolatile(o, offset);
	}while(!compareAndSwapInt(o, offset, v, v+ delta)); //in a CPU atomic action
	return v;
}

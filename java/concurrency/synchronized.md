to ensure entrance, every object's internal localk has a counter and owner thread, 0 - fre, 1, 1 thread, 2+ - reentrance, will reduce the cnt when it is done

lock, biased lock, LWL, HWL, that is the MarkWord in Java object header, BL is ThreadId, LWL pointer to the lokc , HWL, pointer to system Mutex(0|1)
BL for single thread fast access, LWL for threads has some competition and no blocking

HWL depends on OS's futex, involves context switch betwen user state and kernel state, and process CS, that is why BL and LWL was introduced when the contention is actually low

The object header has markword and type pointer, (and length info for the array)
markword has object's Hashcode, GC gen info, lock state, 8 bytes, when LWL, MW stores the the pointer to the Lock Record on the stack

### ReentrantLock
1. If state is 0, CAS to acquire lock. Otherwise, wait at the end of CLH queue. if failed to put into the Q, spin + CAS, and then wait for the unpark()
2. after waking up, try to CAS lock resource, and point ot the head if successful, and then return the interruption signal
3. depends on the AQS, the core of java.concurrent

#HWL
object's markword points to a monitor object on the heap, which has cxq, entryist,waitset, ownero
waitset-lbocking queue
owner-running thread
waiting queue - contentionlist+ entrylist
ready thread- on deck

when a thread tries to acquire lock, if ublae, will encap the thread as a ObjectWaiter and inset into cxq, and then pause the thread
when the owner releases the lock, will move all cxq elemtns to entrylist and wake up the head thread at the cxq

if a thread calls object.wait(), ti will be moved from entrylist to the waitset, and then release the lock, after the waiting thread got notified, the OW will be moved from waitset to the entrylist

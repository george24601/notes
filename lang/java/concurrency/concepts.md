Daemon thread vs user thread
 * GC is a daemon thread

* How many ways to create a thread?
  * inherit from Thread
  * implemnt RUnnable
  * finally use start()
  * start() means thread is ready statu, but not running, and then run() is the actual thing. run() will execute inside the main thread

reentrant lock vs synchronized?

### deadlock
note that deadlock-only case means low CPU usages

Another deadlock prevention mechanism is to put a timeout on lock attempts meaning a thread trying to obtain a lock will only try for so long before giving up. If a thread does not succeed in taking all necessary locks within the given timeout, it will backup, free all locks taken, wait for a random amount of time and then retry.

A better option is to determine or assign a priority of the threads so that only one (or a few) thread backs up. The rest of the threads continue taking the locks they need as if no deadlock had occurred. If the priority assigned to the threads is fixed, the same threads will always be given higher priority. To avoid this you may assign the priority randomly whenever a deadlock is detected.

When all non-daemon threads of a Java application terminate, the virtual machine instance will exit.

To fix deadlock:
* Process-resource graph
 * Resource -> Process: Resource allocated to Process already
 * Process -> Resource: process requests resources
* matrix-based: E, A, C, R

prevention - banker's algorithm


### monitor
The form of monitor used by the Java virtual machine is called a "Wait and Notify" monitor. (It is also sometimes called a "Signal and Continue" monitor.) In this kind of monitor, a thread that currently owns the monitor can suspend itself inside the monitor by executing a wait command. When a thread executes a wait, it releases the monitor and enters a wait set. The thread will stay suspended in the wait set until some time after another thread executes a notify command inside the monitor. When a thread executes a notify, it continues to own the monitor until it releases the monitor of its own accord, either by executing a wait or by completing the monitor region. After the notifying thread has released the monitor, the waiting thread will be resurrected and will reacquire the monitor.

### Nested Monitor Lockout

Notice how the lock() method first synchronizes on "this", then synchronizes on the monitorObject member. If isLocked is false there is no problem. The thread does not call monitorObject.wait(). If isLocked is true however, the thread calling lock() is parked waiting in the monitorObject.wait() call.

The problem with this is, that the call to monitorObject.wait() only releases the synchronization monitor on the monitorObject member, and not the synchronization monitor associated with "this". In other words, the thread that was just parked waiting is still holding the synchronization lock on "this".

### slipped conditions

monitor has two qs, waitset and entrylist, when thread owns the monitor, uses Object.wait(), monitor will be released , and enter the WaitSetQ, thread state will turn WAITING

when object.notify() wakes up this thread, it will try to enter the monitor, will enter ENtryList if failed to acquire monitor, EntryList showls witing for monitor entry, and the staet becomes blocked

CAS: implmented by `unsafe` and the atomicity of native methods

###lost wake up problem

concurrentHashMap.size() is not accurate??

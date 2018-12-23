### AbstractQueuedSynchronizer(AQS)


### CAS

use it to implement an optimistic lock

Basically, compare and swap compares an expected value to the concrete value of a variable, and if the concrete value of the variable is equals to the expected value, swaps the value of the variable for a new variable.

Modern CPUs have built-in support for atomic compare and swap operations. From Java 5 you can get access to these functions in the CPU via some of the new atomic classes in the java.util.concurrent.atomic package.

Heavily used by atomic types in java.util.concurrent

ABA problem: the memory is ABA, so from CAS pov the value is not changed since the last change on A, but it did in fact!


By default PreBlockSpin = 10, so that instead of executting thread swap, in newer java becomes adaptive, decided by the previous # of spin times in the same lock




# biased lock

Thread will store its id in the Mark word. When entering and leaving sync block it iwll not use CAS to lock/unlock, it will CAS the thread id instead

thread will not release biased lock itself. When no bytecode is running, the thread holding biased lock's thread, check if the lock object is locked or not. Cancel biased lock to restore to no-lock(01) or lightweight lock (00)


# lightweight lock
when biased lock is competed by after thead, it will be upgraded to lightweight lock, other thread will spin to try acquiring the lock but will not block

if the sync obj lock is 01, jvm will setup a Lock Record in the stackframe to store the lock object's Mark Word, and then use CAS to change object's markwor to pointer to the Lock Record, and set Lock Record's owner to object's Mark Word, if good, then Mark Word's lock status is 00

Thread will try CAS to the object header's mark word to the pointer to lock record

if update failed, jvm will check object's mark word is pointing to current thread's stack frame, if only 1 waiting, the thread will just spin, if the thread spins too many times, or one thread is hold, one spinning, and a third coming, LW will upgrade to heavy weight lock

When release, try CAD to repalce Mark Word back into object header. if failed, means there is contention with the lock, upgrade to heavyweight lock

# heavyweight lock
When upgrading to heavy weight lock, lock status changed to "10", Mark Word stores pointer to HW lock, all waiting threads wil bokc

based on monitor inside the object, which in turns based on MutexLock from OS - blocking and waking up requiring OS, i.e., from user mode to kenel mode



### synchronized

every object has a monitor lock, montiorenter and monitorexit

Synchronized static methods are synchronized on the class object of the class the synchronized static method belongs to. Since only one class object exists in the Java VM per class, only one thread can execute inside a static synchronized method in the same class.

Every thread has an available monitor record list, and a global available list, every locked object is assocated with a montior, and monitor has an owner section to store the thread holding the the monitor


*  Mark word in object header,e.g., hashcode, ago, bias, lock tag. Object header = mark word + type pointer
* Klass Pointer to the class's meta data 
2. an object in addiotn has the instance data and padding
3. JVM will take note of the thread id/adress of Thread pointer  as the owner of the syncrhonzied object
4. for unbias lock, will assign a Lock Record in the stack frame, as copy the object's mark own to each. Whoever wants to access it will change the address of Lock Record into Mark Word
5. for heavyweight lock,e.g., monitor, need to use Mutex from OS. The synched object will point to the created monitor object

Log has 4 states: none, biased, lightweight, heavyweight, can only upgrade and no downgrade




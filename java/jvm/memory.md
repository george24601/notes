Each thread running in the Java virtual machine has its own thread stack.
The thread stack also contains all local variables for each method being executed (all methods on the call stack)

All local variables of primitive types ( boolean, byte, short, char, int, long, float, double - no String) are fully stored on the thread stack and are thus not visible to other threads.

The heap contains all objects created in your Java application, regardless of what thread created the object.

An object may contain methods and these methods may contain local variables. These local variables are also stored on the thread stack, even if the object the method belongs to is stored on the heap.

An object's member variables are stored on the heap along with the object itself. That is true both when the member variable is of a primitive type, and if it is a reference to an object.

Static class variables are also stored on the heap along with the class definition.

methods, thread stacks, and native handles are allocated in memory separate from the heap
3. VM Stack(includeing stack frames) -thread local

4. native method stack  -thread local. In Hotspot VM Stack and Method Stack are combined.)
	
	* -> Native method interface -> native method libraries
	

5. program coutner register  - thread local


local var table needed ram space is determned during compliation, when entering a method, the size of stack frame is fixed, so it won't change local var table's size


2. what happened when java creates an object?

3. visit an object, handle and direct pointer?

4. string type and constant pool

# Offheap/Native/Direct memory

Direct memory: is similar to native, but also implies that an underlying buffer within the hardware is being shared. For example buffer within the network adapter or graphics display. The goal here is to reduce the number of times the same bytes is being copied about in memory.

Given a direct byte buffer, the Java virtual machine will make a best effort to perform native I/O operations directly upon it. That is, it will attempt to avoid copying the buffer's content to (or from) an intermediate buffer before (or after) each invocation of one of the underlying operating system's native I/O operations. 

However, the application still uses an object on the Java heap to orchestrate I/O operations, but the buffer that holds the data is held in native memory, the Java heap object only contains a reference to the native heap buffer.

The new I/O (NIO) classes introduced a new way of performing I/O based on channels and buffers. NIO added support for direct ByteBuffers, which can be passed directly to native memory rather than Java heap. Making them significantly faster in some scenarios because they can avoid copying data between Java heap and native heap.

Scalability to large memory sizes e.g. over 1 TB and larger than main memory.

Notional impact on GC pause times.

Sharing between processes, reducing duplication between JVMs, and making it easier to split JVMs.

Persistence for faster restarts or replying of production data in test.

The use of off heap memory gives you more options in terms of how you design your system.  The most important improvement is not performance, but determinism.

By storing all your input events and data off heap in a persisted way you can turn your critical systems into a series of complex state machines. (Or in simple cases, just one state machine)

The biggest issue with off heap is your data structures become less natural.  You either need a simple data structure which can be mapped directly to off heap, or you have a complex data structure which serializes and deserializes to put it off heap.

Use cases:

1. session cache in the server app: inactive sessions stored on offheap

2. medium to long lived mutable objects

3. stores keys on heap and values off heap

Eden, Survivor1, and survivor2

#To locate OOM problem

1. jmap -heap
check new and old jen size

2. jmap -histo:live

what is alive, is it too much?

3. /proc/${PID}/fd, /proc/${PID}/task

4. pstree、ss - to check process creation and network connection #

# native method stack

If an implementation's native method interface uses a C-linkage model, then the native method stacks are C stacks. When a C program invokes a C function, the stack operates in a certain way. The arguments to the function are pushed onto the stack in a certain order. The return value is passed back to the invoking function in a certain way. This would be the behavior of the of native method stacks in that implementation.


JNI is designed so it can be supported by any implementation of the Java virtual machine, no matter what garbage collection technique or object representation the implementation uses. This in turn enables developers to link the same (JNI compatible) native method binaries to any JNI-supporting virtual machine implementation on a particular host platform.

### memory size estimate

In a modern 64-bit JDK, an object has a 12-byte header, padded to a multiple of 8 bytes

In an int[dim1][dim2] array instance, every nested int[dim2] array is an Object in its own right. Each adds the usual 16-byte array overhead.

the String class adds another 24 bytes of overhead.

All arrays have an extra integer "length" field stored in their header

The object header consists of a mark word and a klass pointer.

stack can cause out of memory too. OS has limit on # of threads in a process, by experience is about 3000

method area can go OOM by creating many dynamic types

DirectMemory can cause OOM, e.g., java NIO

### recommendation
* Same -Xmx and -Xms, default 1/64 and 1/4 of physical memory
* Bigger new gen, but no need to be big if old gen is on CMS, new gen recommended to be 3/8 of the heap
* method area no longer needs to be big
* default stack size - 1M


Reference Objects???

### To print GC log
* XX:+PrintGCDetalis 
* -Xlog-gc:/data/jvm/gc.log
* -verbose:gc

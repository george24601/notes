methods, thread stacks, and native handles are allocated in memory separate from the heap

heap divided into 2 generations: 
young space => for allocation of new objects, gc is collected by running a special young collection. When all objects that have lived long enough in the nersery are promoted to the old space
old space => old collection is triggered when old collection is full

small objects => thread local areas: free chunks reserved rom the heap and given to a thread for exlcusive use
large objects => directly on the heap

----
GC: mark and sweep
During sweep the heap is traversed to find the gaps between the live objects, gaps are recorded in a free list and are made availble for new object allocation

mostly concurrent mark: =>

mostly concurrent sweep phase: 
=> sweeping of one half of the heap, so that other threads can allocate objects in the part of the heap that is not being swept
=> swtich halves
=> sweeping the other half of the heap

JVM compacts a part of the heap at every old GC. size and position of the compaction area is selected by heuristics
In throughput mode, the compaction area size is static
In other modes. compaction area size changes to keep compaction times equal throughout the run.

external compaction: typically near the top of the heap. Moves the objects within the compatciotn area to free positions outside the compaction area and as far down in the heap as possible
interal compaction: near the bottom where the desity of objects is higher. move objects within the compaction area ar far down int he
ompaction as possible

The postion of the compaction area changes at each GC, using one or two sliding windows to determin the next position


-----
Patterns for fragment problem:
degradation over time, suddenly pops back to excellent, and start degrading again

JVM options: 
Compaction ratio: compact percentage of the heap at each old collection
Compact set limit: how many references there may be from objects outside the compaction area to objects within the compaction area

I just checked on a linux machine with 5gb physical memory. Default max heap shows as 1.5gb

-------
Heap - Java usable memory by devs
non-heap - JVM itself

method region, JIT memory, type and stuff are in the non-heap memory

1. JVM's own memmory, including 3rd party lib, and memories allocated by the memory

2. NIO DirectBuffer -> native memory

class JVM's GC is in per gen, hard to GC

thread stack
 
method region- perm gen -> shared thread ram region
runtime constant, part of method region

local var table needed ram space is determned during compliation, when entering a method, the size of stack frame is fixed, so it won't change local var table's size

program counter: current thread's bytecode's PC

jmap -heap [pid]

jstat -gcutil [pid]

Memory model
--------


Heap - Method Area (including runtime constant pool) - VM Stack(includeing stack frames) - native method stack - program coutner register

Sometime VM Stack and Method Stack are combined.

Method Area: 

	every type's struct info: RCP, String ,and method data, constructor,and normal method's string content
	
	type , instance,interface's special method required on init

Direct memory: is similar to native, but also implies that an underlying buffer within the hardware is being shared. For example buffer within the network adapter or graphics display. The goal here is to reduce the number of times the same bytes is being copied about in memory.

Given a direct byte buffer, the Java virtual machine will make a best effort to perform native I/O operations directly upon it. That is, it will attempt to avoid copying the buffer's content to (or from) an intermediate buffer before (or after) each invocation of one of the underlying operating system's native I/O operations. 

However, the application still uses an object on the Java heap to orchestrate I/O operations, but the buffer that holds the data is held in native memory, the Java heap object only contains a reference to the native heap buffer.


# Offheap/Native memory

Native memory/Off-heap: is memory allocated within the processes address space that is not within the heap.

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



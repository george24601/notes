TLAB: thread local allocation buffer

local var table needed ram space is determned during compliation, when entering a method, the size of stack frame is fixed, so it won't change local var table's size


2. what happened when java creates an object?

3. visit an object, handle and direct pointer?  two ways to locate object: handle, direct pointer

4. string type and constant pool

# Offheap/Native/Direct memory

Direct memory: is similar to native, but also implies that an underlying buffer within the hardware is being shared. For example buffer within the network adapter or graphics display. The goal here is to reduce the number of times the same bytes is being copied around in memory.

However, the application still uses an object on the Java heap to orchestrate I/O operations, but the buffer that holds the data is held in native memory, the Java heap object only contains a reference to the native heap buffer.

Scalability to large memory sizes e.g. over 1 TB and larger than main memory.

Sharing between processes, reducing duplication between JVMs, and making it easier to split JVMs.

Persistence for faster restarts or replying of production data in test.

Use cases:

1. session cache in the server app: inactive sessions stored on offheap
2. medium to long lived mutable objects
3. stores keys on heap and values off heap


### memory size estimate

In a modern 64-bit JDK, an object has a 12-byte header, padded to a multiple of 8 bytes

In an int[dim1][dim2] array instance, every nested int[dim2] array is an Object in its own right. Each adds the usual 16-byte array overhead.

the String class adds another 24 bytes of overhead.

All arrays have an extra integer "length" field stored in their header

The object header consists of a mark word and a klass pointer.

stack can cause out of memory too. OS has limit on # of threads in a process, by experience is about 3000

method area can go OOM by creating many dynamic types

DirectMemory can cause OOM, e.g., java NIO

Reference Objects???

### Metaspace
In JDK 1.8, method area no longer exists, compile code and data moved to metaspace, it no longer uses heap, uses native memory instead

Constants (class variables declared final) are not treated in the same way as non-final class variables. Every type that uses a final class variable gets a copy of the constant value in its own constant pool. 

If the virtual machine is unable to load the requested type into the current name space, forName() will throw ClassNotFoundException.

An alternative way to get a Class reference is to invoke getClass() on any object reference. This method is inherited by every object from class Object itself:

string pool/string literal pool: stored the references in a StringTable, but the actual objects are on the heap

runtime constant pool: inside the method area? one for each class durng the run, JVM put class contant pool into runtime contant pool


String s0="kvill";
String s3="kv" + "ill";
System.out.println( s0==s3 );//true


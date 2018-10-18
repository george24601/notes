heap divided into 2 generations: 
young space => for allocation of new objects, gc is collected by running a special young collection. When all objects that have lived long enough in the nersery are promoted to the old space. New gen is devided further into Eden, from suvivor, to survivor
old space => old collection is triggered when old collection is full

small objects => thread local areas: free chunks reserved from the heap and given to a thread for exlcusive use

large objects => directly on the heap

During sweep the heap is traversed to find the gaps between the live objects, gaps are recorded in a free list and are made availble for new object allocation

mostly concurrent mark

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


# where are the GC roots?

GC root : referred by local variables in VM stackframe

method area, referred by class static 

method area, referred by constant

local method stack, referred by JNI

so gc root exists in method area, stack, and local method area - referenced by GC roots will not be GCed.  can GC root be on heap too?

gc uses a daemon thread inside JVM

#unloading types

if an implementation uses a mark and sweep algorithm, it must be able to mark an object as referenced or unreferenced. For each unreferenced object, it may also need to indicate whether or not the object's finalizer has been run. As with thread locks, this data may be kept separate from the object image.


The way in which a Java virtual machine can tell whether a dynamically loaded type is still needed by the application is similar to the way it tells whether an object is still needed by the program. If the application has no references to the type, then the type can't affect the future course of computation. The type is unreachable and can be garbage collected.

Types loaded through the bootstrap class loader will always be reachable and never be unloaded. Only types loaded through user-defined class loaders can become unreachable and be unloaded by the virtual machine. A type is unreachable if its Class instance is found to be unreachable through the normal process of garbage collecting the heap.

implementations must be able to locate the type data in the method area for an object's class, given only a reference to the object. For this reason, the image of an object on the heap likely includes some kind of pointer to its type data in the method area. From the type data, the virtual machine must be able to locate the Class instances for the object's class, all its superclasses, and all its superinterfaces.

Thus, given only a reference to a reachable instance of class MyThread, the garbage collector is able to "reach" the Class instances for MyThread and all its supertypes: Cloneable, Thread, Runnable, and Object.


### from the JVM book

In addition to freeing unreferenced objects, a garbage collector may also combat heap fragmentation. Heap fragmentation occurs through the course of normal program execution. New objects are allocated, and unreferenced objects are freed such that free portions of heap memory are left in between portions occupied by live objects. Requests to allocate new objects may have to be filled by extending the size of the heap even though there is enough total unused space in the existing heap. This will happen if there is not enough contiguous free heap space available into which the new object will fit.

Garbage detection is ordinarily accomplished by defining a set of roots and determining reachability from the roots.

The roots are always accessible to the program.

The root set in a Java virtual machine is implementation dependent, but would always include any object references in the local variables and operand stack of any stack frame and any object references in any class variables. Another source of roots are any object references, such as strings, in the constant pool of loaded classes. The constant pool of a loaded class may refer to strings stored on the heap, such as the class name, superclass name, superinterface names, field names, field signatures, method names, and method signatures. Another source of roots may be any object references that were passed to native methods that either haven't been "released" by the native method. (Depending upon the native method interface, a native method may be able to release references by simply returning, by explicitly invoking a call back that releases passed references, or some combination of both.) Another potential source of roots is any part of the Java virtual machine's runtime data areas that are allocated from the garbage-collected heap. For example, the class data in the method area itself could be placed on the garbage-collected heap in some implementations, allowing the same garbage collection algorithm that frees objects to detect and unload unreferenced classes.

### GC algorithms

Some garbage collectors, however, may choose not to distinguish between genuine object references and look-alikes. Such garbage collectors are called conservative because they may not always free every unreferenced object. Sometimes a garbage object will be wrongly considered to be live by a conservative collector, because an object reference look-alike referred to it.

Two basic approaches to distinguishing live objects from garbage are reference counting and tracing. Reference counting garbage collectors distinguish live objects from garbage objects by keeping a count for each object on the heap. The count keeps track of the number of references to that object. Tracing garbage collectors actually trace out the graph of references starting with the root nodes. Objects that are encountered during the trace are marked in some way. After the trace is complete, unmarked objects are known to be unreachable and can be garbage collected.

Marking is generally done by either setting flags in the objects themselves or by setting flags in a separate bitmap.

The basic tracing algorithm is called "mark and sweep." This name refers to the two phases of the garbage collection process. In the mark phase, the garbage collector traverses the tree of references and marks each object it encounters. In the sweep phase, unmarked objects are freed, and the resulting memory is made available to the executing program. In the Java virtual machine, the sweep phase must include finalization of objects.

### Compacting Collectors

Compacting collectors slide live objects over free memory space toward one end of the heap. In the process the other end of the heap becomes one large contiguous free area. All references to the moved objects are updated to refer to the new location.

Updating references to moved objects is sometimes made simpler by adding a level of indirection to object references. Instead of referring directly to objects on the heap, object references refer to a table of object handles. The object handles refer to the actual objects on the heap. When an object is moved, only the object handle must be updated with the new location. All references to the object in the executing program will still refer to the updated handle, which did not move. While this approach simplifies the job of heap defragmentation, it adds a performance overhead to every object access.

### Copying Collectors

Copying garbage collectors move all live objects to a new area. As the objects are moved to the new area, they are placed side by side, thus eliminating any free space that may have separated them in the old area. The old area is then known to be all free space. The advantage of this approach is that objects can be copied as they are discovered by the traversal from the root nodes. There are no separate mark and sweep phases. Objects are copied to the new area on the fly, and forwarding pointers are left in their old locations. The forwarding pointers allow the garbage collector to detect references to objects that have already been moved. The garbage collector can then assign the value of the forwarding pointer to the references so they point to the object's new location.

A common copying collector algorithm is called "stop and copy." In this scheme, the heap is divided into two regions. Only one of the two regions is used at any time. Objects are allocated from one of the regions until all the space in that region has been exhausted. At that point program execution is stopped and the heap is traversed. Live objects are copied to the other region as they are encountered by the traversal. When the stop and copy procedure is finished, program execution resumes. Memory will be allocated from the new heap region until it too runs out of space. At that point the program will once again be stopped. The heap will be traversed and live objects will be copied back to the original region. The cost associated with this approach is that twice as much memory is needed for a given amount of heap space because only half of the available memory is used at any time.

### Generational Collectors

In this approach, the heap is divided into two or more sub-heaps, each of which serves one "generation" of objects. The youngest generation is garbage collected most often. As most objects are short-lived, only a small percentage of young objects are likely to survive their first collection. Once an object has survived a few garbage collections as a member of the youngest generation, the object is promoted to the next generation: it is moved to another sub-heap. Each progressively older generation is garbage collected less often than the next younger generation. As objects "mature" (survive multiple garbage collections) in their current generation, they are moved to the next older generation.

The generational collection technique can be applied to mark and sweep algorithms as well as copying algorithms. In either case, dividing the heap into generations of objects can help improve the efficiency of the basic underlying garbage collection algorithm.

### train algorithm

The train algorithm divides the mature object space into fixed-sized blocks of memory, each of which is collected individually during a separate invocation of the algorithm.

Each time the train algorithm is invoked, it will garbage collect one and only one block: the lowest numbered block

Objects arrive in the mature object space when they get old enough to be promoted from the sub-heap of a younger generation. Whenever objects are promoted into the mature object space from younger generations, they are either added to any existing train except the lowest-numbered train, or one or more new trains are created to hold them.

### reachability

An object is in the resurrectable state if it is not currently reachable by tracing the graph of references starting with the root nodes, but could potentially be made reachable again later when the garbage collector executes some finalizer. All objects, not just objects that declare a finalize() method, pass through the resurrectable state. As mentioned in the previous section, the finalizer for an object may "resurrect" itself or any other resurrectable object by making the objects reachable again. Because any object in the resurrectable state could potentially be made reachable again by its own or some other object's finalize() method, the garbage collector cannot reclaim the memory occupied by a resurrectable object before it makes certain the object won't be brought back to life through the execution of a finalizer. By running the finalizers of all resurrectable objects that declare a finalize() method, the garbage collector will transform the state of all resurrectable objects, either back to the reachable state (for objects that get resurrected), or forward to the unreachable state.

Any object referenced directly from a root node, such as a local variable, is strongly reachable. Likewise, any object referenced directly from an instance variable of a strongly reachable object is strongly reachable.

Reference Objects???

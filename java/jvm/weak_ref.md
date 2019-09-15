Metaspace OOM issue caused by low SoftRef LRU time. The metaspace itself is most likely populated by internal class objected created via exception

Why do we need that in thread local map?

1. useful for ref counting GC
2. key to refer to object
3. listener for the observer pattern, otherwise lapsed listener problem
4. recreatable cached data

parent to child: strong ref
child to parent: weak ref

soft ref: on GC, JVM will decide to recyle soft ref or not. often used for cache
Weak ref: will be recycled in the next GC for sure, another common use for cache
Phantom Reference: rarely used. Used together with reference queue. Mainly used to trace GC process
When GC decides to gc an object, will destroy to object, and add teh phantom ref to the ref queu. if the program finds tha the phanfom ref has been added into ther ref que, then it is a sign that object will be GCed soon



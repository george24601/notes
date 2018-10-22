Hashmap, TreeMap, LinkedHashMap, HashTab, thread-safe maps. How concurrentMap, ConcurrentHashMap vs HashMap

CyclicBarrier

NIO - selector, blocking and non-blocking, BIO vs NIO, AIO?

class loader - double parent delegation
dual parent loading - same class as java class name? different types of class loader?

object life cycle from creation to destruction

Design: deduct money not into negative (distirbuted transaction and lock), Idempotency (can not deduct more than once)

distributed session settings, consistency, idempotency

use of jmap and jutil?

protential problem with bouldless blocking queue?

Design: service's interfact implementation, load balance and route robin between 3 IPs (consider concurrency case)

Generics, type erasing at compile time, so that run time has no type info

< ? extends T>, <? super T>, and <?>,

Design: use generics to implement LRU, hints: LinkedHashMap, removeEldestEntry()

can you pass List<String> as List<Object> param? How about vice versa?  
answer is no - contravariant and co-variant

Example of type unchecked warning,e.g.,  List<String> rawList = new ArrayList()

class type.newInstance, ConstructorType.newInstance - classType newInstance calls reflection constructor type's parameter-less methods

gc - when, how, different gc strategy?

memory - during object creation and destruction, what memory region is affected

G1 vs CMS

class object

string pool will NOT be GCed - string pool concat is done at COMPILE time, at RUNTIME, created is put on heap e.g. "TEST" + myVar 

Difference between Thread.run and Thread.start

When will reflection not get the params?

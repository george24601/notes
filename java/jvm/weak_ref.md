Why do we need that in thread local map?

1. useful for ref counting GC
2. key to refer to object
3. listener for the observer pattern, otherwise lapsed listener problem
4. recreatable cached data

parent to child: strong ref
child to parent: weak ref

soft ref: on GC, JVM will decide to recyle soft ref or not. 
Weak ref: will be recycled in the next GC for sure
Phantom Reference: rarely used?



###Hashmap

hashmap init size is 16? =>  i = (n - 1) & hash, when n is 2^n, it is equal to n % hash, because & is faster than mod

the full load factor is 0.75. turn to RBT at 8, back to LL at 6, turning on only if size >= 64

When we rehash, the new bucket can be either at the original, or the original key + original capacity

aside from linkedlist, probing opening bucket is also a possible solution

concurrent hashmap uses Unsafe to do native CAS

copyonwritearraylist, why no concurrentArraylist?

### Hashmap
array (default 16) + linked list, inserted into head
on 0.75 load, double the capacity, the main benefit is that length-1 is all 1, means we can use the last few bits of hashcode as the index
When array lenght > 64 and some link lenght > 8, this linked list will be changed to RBT

Hashtable is thread safe, default size 11, nowadays concurrent hashmap is used more.

CHM(1.7): by segment array, each segment is a hashmap by itself, 2^N segments in concurrentHashmap called segment
Put:
* calcuate hash of key
* via hash, locate corresponding Segment
* acquire re-entrance lock
* from hash,locate the array index inside the segment
* insert or cover HashEntry
* release lock
Get:
* get key's hash, locate the segment
* use the hash to locate array index inside the segment

CHM(1.8):
Node array + CAS + Synchronized + Unsafe: 
value and next are volativle, can't setVlaue directly to change Node's value

, similarly, the underlying structure is array + linkedlist + RBT

what is the hashmap's inital capacity and size increase factor?

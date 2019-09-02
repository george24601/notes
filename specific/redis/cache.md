### Defense against stampede

Or, if want to update from the client side:
  * To solve it, set a mutex key (SETNX), and then load db and set the cache. Otherwise, retry the whole get cache method
  * Alternatively, inside value itself set a timeout value to1 (which is less than to2), when we read the cache and find it already expired, we extend timeout1, and reset it on cache. service layer will extend the renew period, and itself will renew, while others still think it is safe to use the cache
  * do not send expiring time, but store the logical value inside the value, if we find it is about to expire, use a background thread to update construct the value asyncly

every dictEntry: 66 bytes, bucket size is closest 2^n, each element 8 bytes (i.e., size of the pointer)

### Zhihu's redis clusters

* 70TB total memory, used 40 TB
* 15M rps across the cluster
* single cluster 4M rps peak
* 800 clusters
* 20G storage or 200k rps - use cluster mode

### sequenctial calls latency problem

The reason is that processes in a system are not always running, actually it is the kernel scheduler that let the process run, so what happens is that, for instance, the benchmark is allowed to run, reads the reply from the Redis server (related to the last command executed), and writes a new command. The command is now in the loopback interface buffer, but in order to be read by the server, the kernel should schedule the server process (currently blocked in a system call) to run, and so forth. So in practical terms the loopback interface still involves network-alike latency, because of how the kernel scheduler works.

Because moving hash slots from a node to another does not require to stop operations, adding and removing nodes, or changing the percentage of hash slots hold by nodes, does not require any downtime.

Use BF to filter out obvious nos

Use lock when fetch value from db to defend against penetration

against stampdede/cascading failure, ideally db shoudl be able to handle that, if too hard, rate limiting is a must combiled with persisted recovered and active-standby clusters

expire key: random deletiion (repeating if the expriation ratio > 1/4)  + lazy deletion on get + LRU (e.g., with LinkedHashMap)

every sec randomly select 5 nodes,and find the oldest node that has not sent message too. Every 100ms, scale lcoal node list, if the node received last pong > cluster-node-timeout/2, send ping

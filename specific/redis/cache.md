### Size estimate for "hello" -> "world"
dictEntry: 25 bytes
redisObject: 16 Buytes
key: 5 + 9 bytes
value: 5 + 9 bytes

so a dict needs 32 + 15 + 16 + 16 = 80 bytes

fork time is related to memory, recommend to keep redis instance size no more than 10G, about 20ms to form 1G memory

use : to separate keys
keep value no more than 10KB

disable KEYS command in config

Because moving hash slots from a node to another does not require to stop operations, adding and removing nodes, or changing the percentage of hash slots hold by nodes, does not require any downtime.

every sec randomly select 5 nodes,and find the oldest node that has not sent message too. Every 100ms, scale lcoal node list, if the node received last pong > cluster-node-timeout/2, send ping


### bgsave
Forks a child process and writes via that process. Otherwise, the main process will just block. Child process at init share the same data segment and code segment, and will copy on write if child wants to change the data

follow up changes are in memory buffer. The RDB file will be copied to the replica, and then replay the AOF log

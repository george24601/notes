
When the benchmark is allowed to run, reads the reply from the Redis server (related to the last command executed), and writes a new command. The command is now in the loopback interface buffer, but in order to be read by the server, the kernel should schedule the server process (currently blocked in a system call) to run, and so forth. So in practical terms the loopback interface still involves network-alike latency, because of how the kernel scheduler works.

Because moving hash slots from a node to another does not require to stop operations, adding and removing nodes, or changing the percentage of hash slots hold by nodes, does not require any downtime.

every sec randomly select 5 nodes,and find the oldest node that has not sent message too. Every 100ms, scale lcoal node list, if the node received last pong > cluster-node-timeout/2, send ping


### bgsave
Forks a child process and writes via that process. Otherwise, the main process will just block. Child process at init share the same data segment and code segment, and will copy on write if child wants to change the data

In the prepare phase, all microservices will be asked to prepare for some data change that could be done atomically. Once all microservices are prepared, the commit phase will ask all the microservices to make the actual changes.

Once CustomerMicroservice is OK to perform the change, it will lock down the object from further changes and tell the Coordinator that it is prepared. The same thing happens while creating the order in the OrderMicroservice. Once the Coordinator has confirmed all microservices are ready to apply their changes, it will then ask them to apply their changes by requesting a commit with the transaction. At this point, all objects will be unlocked.

2pc is synchronous (blocking). The protocol will need to lock the object that will be changed before the transaction completes.

2pc is how TM coordinates RM


Unlike Percolator, Spanner’s architecture is not based on BigTable. It resembles Megastore more closely and uses Colossus as its file system. A Spanner deployment is called a “universe”. A universe auto shards and auto rebalances data across many sets of Paxos state machines located in multiple zones at datacenters spread all over the world.

A zone has one zonemaster and possibly 1000s of spanservers. The former assigns data to spanservers; the latter serve data to clients.

At every replica that is a leader, each spanserver implements a lock table to support two-phase-locking based concurrency control and a transaction manager to support distributed transactions. If a transaction involves only one Paxos group (as is the case in single row & single shard transactions), it bypasses the transaction manager. The lock table and Paxos together are enough to do the job here. If a transaction involves more than one Paxos group (as is the case in distributed transactions), those groups’ leaders coordinate to perform two-phase commit. The state of the transaction manager is also modeled as a persistent Paxos group to ensure continued availability.

The most noteworthy innovation in Spanner is that it achieves external consistency, an isolation level even stricter than serializability, by assigning global commit timestamps to all transactions using the TrueTime API. TrueTime is Google’s highly reliable “wall-clock” time tracking service (with a bounded uncertainty of 7ms) that is built on GPS and atomic clocks.

We believe it is better to have application programmers deal with performance problems due to overuse of transactions as bottlenecks arise, rather than always coding around the lack of transactions. Running two-phase commit over Paxos mitigates the availability problems.

 In active/active, the benefit of write scaling is negated by conflict-ridden concurrent writes on same rows at different masters. Such conflicts are resolved without explicit knowledge of the app using non-deterministic heuristics such as Last-Write-Wins (LWW) and Conflict-Free Replicated Data Types (CRDT)

Achieving Isolation
The transaction manager cannot simply stamp all the operations inside a single transaction with its own time — other instances of the transaction manager on other nodes can operate on the same data but won’t have the same view of the time. Getting even a partial ordering of the operations in a transaction becomes a challenge. Protocols such as Network Time Protocol (NTP) allow the times at each node to be synchronized over the public internet with a common source of truth but there’s still no guarantee that all nodes will see the exact same time since internet network latency is unpredictable. In reality, nodes exhibit clock skew/drift even with NTP turned on. So a more sophisticated time tracking mechanism is needed.

 Implementing distributed ACID transactions in scale-out DBs requires the use of a transaction manager that can coordinate the various operations and then commit/rollback the transaction as needed.

 Apple’s recently open sourced FoundationDB follows a similar design philosophy where transactions are handled using a transactional authority.



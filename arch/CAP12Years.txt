The modern CAP goal should be to maximize combinations of consistency and availability that make sense for the specific application. Such an
approach incorporates plans for operation during a partition and for recovery afterward, 

Allowing at least one node to update state will cause the nodes to become inconsistent, thus forfeiting C. Likewise, if the choice is to
preserve consistency, one side of the partition must act as if it is unavailable, thus forfeiting A

First, because partitions are rare, there is little reason to forfeit C or A when the system is not partitioned. Second, the choice between
C and A can occur many times within the same system at very fine granularity; not only can subsystems make different choices, but the choice
can change according to the operation or even the specific data or user involved. Finally, all three properties are more continuous than
binary. Availability is obviously continuous from 0 to 100 percent, but there are also many levels of consistency, and even partitions have
nuances, including disagreement within the system about whether a partition exists.


Because partitions are rare, CAP should allow perfect C and A most of the time, but when partitions are present or perceived, a strategy
that detects partitions and explicitly accounts for them is in order. This strategy should have three steps: detect partitions, enter an
explicit partition mode that can limit some operations, and initiate a recovery process to restore consistency and compensate for mistakes
made during a partition.

 Isolation is at the core of the CAP theorem: if the system requires ACID isolation, it can operate on at most one side during a partition.
Serializability requires communication in general and thus fails across partitions. Weaker definitions of correctness are viable across
partitions via compensation during partition recovery.

Retrying communication to achieve consistency, for example, via Paxos or a two-phase commit, just delays the decision. At some point the
program must make the decision; retrying communication indefinitely is in essence choosing C over A.

This pragmatic view gives rise to several important consequences. The first is that there is no global notion of a partition, since some
nodes might detect a partition, and others might not. The second consequence is that nodes can detect a partition and enter a partition
mode-a central part of optimizing C and A.

Facebook uses the opposite strategy:6 the master copy is always in one location, so a remote user typically has a closer but potentially
stale copy. However, when users update their pages, the update goes to the master copy directly as do all the user’s reads for a short time,
despite higher latency. After 20 seconds, the user’s traffic reverts to the closer copy, which by that time should reflect the update.

 This exception, commonly known as disconnected operation or offline mode,7 is becoming increasingly important. Some HTML5 features-in
particular, on-client persistent storage-make disconnected operation easier going forward. These systems normally choose A over C and thus
must recover from long partitions.

within a primary partition, it is possible to ensure complete consistency and availability, while outside the partition, service is not
available. Paxos and atomic multicast systems typically match this scenario.8 In Google, the primary partition usually resides within one
datacenter; however, Paxos is used on the wide area to ensure global consensus, as in Chubby,

choosing CA should mean that the probability of a partition is far less than that of other systemic failures, such as disasters or multiple
simultaneous faults.

nvariant that keys in a table are unique, designers typically decide to risk that invariant and allow duplicate keys during a partition.
Duplicate keys are easy to detect during recovery, and, assuming that they can be merged, the designer can easily restore the invariant.

 Externalized events, such as charging a credit card, often work this way. In this case, the strategy is to record the intent and execute it
after the recovery. Such transactions are typically part of a larger workflow that has an explicit order-processing state, and there is
little downside to delaying the operation until the partition ends. The designer forfeits A in a way that users do not see. The users know
only that they placed an order and that the system will execute it later.

One reason to focus on explicit atomic operations, rather than just reads and writes, is that it is vastly easier to analyze the impact of
higher-level operations on invariants. 

The best way to track the history of operations on both sides is to use version vectors, which capture the causal dependencies among
operations. The vector’s elements are a pair (node, logical time), with one entry for every node that has updated the object and the time of
its last update. Given two versions of an object, A and B, A is newer than B if, for every node in common in their vectors, A’s times are
greater than or equal to B’s and at least one of A’s times is greater.

f it is impossible to order the vectors, then the updates were concurrent and possibly inconsistent. Thus, given the version vector history
of both sides, the system can easily tell which operations are already in a known order and which executed concurrently. Recent work14
proved that this kind of causal consistency is the best possible outcome in general if the designer chooses to focus on availability.
---------
igner must solve two hard problems during recovery:
the state on both sides must become consistent, and
there must be compensation for the mistakes made during partition mode.

ome systems can always merge conflicts by choosing certain operations. A case in point is text editing in Google Docs,17 which limits
operations to applying a style and adding or deleting text. Thus, although the general problem of conflict resolution is not solvable, in
practice, designers can choose to constrain the use of certain operations during partitioning so that the system can automatically merge
state during recovery. Delaying risky operations is one relatively easy implementation of this strategy.


cated data types (CRDTs), a class of data structures that provably converge after a partition, and describe how to use these structures to

ensure that all operations during a partition are commutative, or
represent values on a lattice and ensure that all operations during a partition are monotonically increasing with respect to that lattice.
The latter approach converges state by moving to the maximum of each side’s values. It is a formalization and improvement of what Amazon
does with its shopping cart:20 after a partition, the converged value is the union of the two carts, with union being a monotonic set
operation. The consequence of this choice is that deleted items may reappear.

RDTs can also implement partition-tolerant sets that both add and delete items. The essence of this approach is to maintain two sets: one
each for the added and deleted items, with the difference being the set’s membership. Each simplified set converges, and thus so does the
difference. At some point, the system can clean things up simply by removing the deleted items from both sets. However, such cleanup
generally is possible only while the system is not partitioned. In other words, the designer must prohibit or postpone some operations
during a partition, but these are cleanup operations that do not limit perceived availability. Thus, by implementing state through CRDTs, a
designer can choose A and still ensure that state converges automatically after a partition.

--------------


RDTs allow only locally verifiable invariants-a limitation that makes compensation unnecessary but that somewhat decreases the approach’s
power. However, a solution that uses CRDTs for state convergence could allow the temporary violation of a global invariant, converge the
state after the partition, and then execute any needed compensations.

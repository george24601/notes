Workflow 1
----------
1. main service calls try on all sub services, and log all in the activity monitor

3. if all tries are good, the main service executes local tnx, send confirm/cancel to AM, AM will cofirm on sub services, if they are good, AM tells main service to submit (an ACK will be enough). Otherwise, AM will use the cancel endpoints on the subservices 

4. if any of the sub services falied to try, the main service will rollback and over. The successful tries will use a batch job to cancel good tried that timed out - roll back them.  The net result: cancel everywhere (after some time).

5. no need to execute service 2's commit immediately, can do it asynchly

6. cancel needs to be idempotent, and needs to handle various cases. note that we need to handle confirm failure case, i.e., rollback all confirms, and cancel


TCC needs local RM support


Can combine TCC with MQ based solution

1. try: persist message

2. confirm: send message

3. cancel: delete message

SPEICAL CASE: cancel BEFORE try/confirm.

This means during rollback

1. mark the OOO try as rollback only - can not execute

2. disable its context transfer into other remote branch, to avoid the cascading effect

3.  In try/confirm race case, confirm must go after try, have to block Confirm upon discovery of racing try

4. After entering Confirm, can't submit new try with the same global transaction


Each entity has a unique identifier or key. Entities represent disjoint sets of data. Each datum resides in exactly one entity. The data of an entity never overlaps the data of another entity

You can’t have a transaction that spans more than one entity, for the simple reason that you have no way of guaranteeing multiple entities will reside on the same system. (Remember, we’re talking about aggregate entities here).

One possible representation is as a collection of SQL records (potentially across many tables) whose primary key begins with the entity key.

The scale-agnostic application program can’t atomically update an entity and its alternate index! The upper-layer scale-agnostic application must be designed to understand that alternate indices may be out of sync with the entity accessed with its primary index (i.e. entity key).

The lower layer of the application understands the fact that more computers get added to make the system scale. In addition to other work, it manages the mapping of the upper layer’s code to the physical machines and their locations. The lower layer is scale-aware in that it understands this mapping. We are presuming that the lower layer provides a scale-agnostic programming abstraction to the upper layer

2PC assumes that data in stable storage is never lost. No node cashes forever

Classic 2PC will block when a machine fails unless the coordinator and participants in the transaction are fault tolerant in their own right such as the Tandem NonStop System. Paxos and Raft do not block with node failures but do extra work coordinating much like Tandem's system.

In a system that cannot count on distributed transactions, the management of uncertainty must be implemented in the business logic. The uncertainty of the outcome is held in the business semantics rather than in the record lock. This is simply workflow. It's not magic. You can't use distributed transactions, so you use workflow.

When considering almost-infinite scaling, it is interesting to think about two-party relationships. By building up from two-party tentative/cancel/confirm (just like traditional workflow), you can see the basis for achieving distributed agreement. Just as in the escrow company (see sidebar), many entities may participate in an agreement through composition.





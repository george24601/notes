A saga is a sequence of local transactions. Each local transaction updates the database and publishes a message or event to trigger the next local transaction in the saga. If a local transaction fails because it violates a business rule then the saga executes a series of compensating transactions that undo the changes that were made by the preceding local transactions.

You should define the steps in a compensating transaction as idempotent commands.

Placing a short-term timeout-based lock on each resource that's required to complete an operation, and obtaining these resources in advance, can help increase the likelihood that the overall activity will succeed. The work should be performed only after all the resources have been acquired. All actions must be finalized before the locks expire.

Consider using retry logic that is more forgiving than usual to minimize failures that trigger a compensating transaction. If a step in an operation that implements eventual consistency fails, try handling the failure as a transient exception and repeat the step. Only stop the operation and initiate a compensating transaction if a step fails repeatedly or irrecoverably.

Choreography - Peer to Peer, distributed
-------

1. The Order Service creates an Order in a PENDING state and publishes an OrderCreated event to Cutomser Service

2. The Customer Service receives the event attempts to reserve credit for that Order. It publishes either a Credit Reserved event or a CreditLimitExceeded event to Order Service

3. The Order Service receives the event and changes the state of the order to either approved or cancelled

5. Note that this workflow implies a cyclic dependency between services - how to decouple?

6. Watch out the death star effect, by that time we may need a centralized design


Orchestration with Saga as coordinator, centralized
--------
1. The Order Service creates an Order in a pending state and creates a CreateOrderSaga

2. The CreateOrderSaga sends a ReserveCredit command to the Customer Service

3. The Customer Service attempts to reserve credit for that Order and sends back a reply

4. The CreateOrderSaga receives the reply and sends either an ApproveOrder or RejectOrder command to the Order Service

5. The Order Service changes the state of the order to either approved or cancelled

6. In order to be reliable, a service must atomically update its database AND publish an event. E.g., one of the patterns

	a. Event sourcing

	b. Application events

	c. Database triggers

	d. Transaction log tailing


Servicecomb 
------------
The coordinator is stateless and thus can have multiple instances.

All transaction events are stored in database permanently.

Saga doens't guarantee isolation:

1. lost update problem 

2. dirty read problem: read unsubmitted data 

3. non-repetable read: read submitted data from another txn in between


use a semantic lock to mark possible dirty read - but need timeout as deadlock prevention

can also use commutatitve updates to compensate to defend the lost update problem

pessimistic view to avoid compenstation - no dirty read

re-read value before update

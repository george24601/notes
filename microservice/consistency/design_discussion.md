1. Scope of cross service transaction

	a. Use Saga/TCC for services on the crital path, and limit the critical path as much as you can.

	b. For example, for a payment to wallet transaction. Notification service and point services should be on the critial path. The account balance and wallet services should be on the critical path.

2. TCC vs Saga vs Message-based. This actually not the crtical design decision, because TCC and Saga are similar, and both needs.

4. Write for our specifc cases vs use existing framework. No production grade framework available, since it is such a niche problem. This means we should write our own, domain-specific logic


Context
--------
A payment transfer has multiple payment methods, we want to use all available one, or mark the transfer as failure.

Design: decentralized saga
----------

1. Payment creates a transfer in PENDING state, and sends a Transfer request to PAD

2. PAD sets the reservation in pending state, reserves the corresponding PAD balance, and sends the remaining balance to CC

3. CC will reserve the remaining service, and return success

4. PAD will change the transfer state to success, and return to Payment

5. Payment will change the transfter state to success, and return

6. Have a cron job that periodically scans pending transfer tables, and cancels timedout ones, based on our SLA, (e.g., 1 mins)

7. Note that for canceled process, even if this service doesn't have the record, it should populate the downstream service, because we need to ensure that that cancel and try are commutative,i.e., if cancel arrives before try, the late coming try should be cancelled.



Design: centralized saga
----------

1. Payment creates a Transfer in PENDING state, and creates a stateless TransferCoordinator (TC). Most likely still within payment's process

2. TC sends the transfer request to PAD

3. After TC receivies the success response from PAD, TC sends the transfer request to CC  

4. After TC receives the success response from CC, TC sends Create or Reject back to the Payment 

5. The cancel process is similar to the decentralized design


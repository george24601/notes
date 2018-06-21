1. Scope of cross service transaction

	a. Use Saga/TCC for services on the crital path, and limit the critical path as much as you can.

	b. For example, for a payment to wallet transaction. Notification service and point services should be on the critial path. The account balance and wallet services should be on the critical path.

2. TCC vs Saga vs Message-based

3. Decentralized/P2P or centralized/coordinator based?

4. Write for our specifc cases vs use existing framework

5. Design 1: decentralized

6. Design 2: centralized



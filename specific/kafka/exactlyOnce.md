Exactly-once processing is an end-to-end guarantee and the application has to be designed to not violate the property as well. If you are using the consumer API, this means ensuring that you commit changes to your application state concordant with your offsets as described here.

To achieve exactly-once processing semantics, we must have a closed system with end-to-end support for modeling input, output, and processor state as a single, atomic operation. Kafka supports this by providing a new transaction API and idempotent producers.

idempotent producers
transactional, atomic, writes across partitions
Kafka-based offset storage

With idempotency turned on, each producer gets a unique id (the PID), and each message is sent together with a sequence number. When either the broker or the connection fails, and the producer retries the message send, it will only be accepted if the sequence number of that message is 1 more than the one last seen.

Note, however, that if the producer fails and restarts, it will get a new Pid (or the same one, but with a new epoch number, when a TransactionalId is specified in the config). Hence, the idempotency guarantees only span a single producer session.

Using it, it’s possible to atomically write data to multiple topics and partitions along with offsets of consumed messages. If we take a closer look at what a single processing step does, it reads data from one or more source topics, performs a computation, and writes the data back to one or more target topics. And we can capture this as an atomic Kafka transaction unit: writing to target topics, and storing the offsets in source topics.

How to make sure this is done exactly-once? Here it’s possible provided that the consumer is transactional, i.e. if we can store the result of processing of a given message, along with its offset, together as an atomic unit in the target system.

Alternatively, this will also work if the sink is idempotent. In fact, if our processing stages are idempotent, we don’t really need any of the additional exactly-once features: at-least-once is good enough.

When using transactions, you shouldn't use ANY consumer-based mechanism, manual or otherwise, to commit the offsets.

Instead, you use the producer to send the offsets to the transaction so the offset commit is part of the transaction.

Note that enable.idempotence must be enabled if a TransactionalId is configured.

PID and a sequence number is bundled together with the message and sent to the broker. Since sequence number starts from zero and is monotonically increasing, a Broker will only accept the message if the sequence number of the message is exactly 1 greater than the last committed message from that PID/TopicPartition pair.

Some messages may get lost due to high sequence number leading to an out-of-sequence error.

Idempotent producer ensures exactly once message delivery per partition, in order to do so in multiple partitions, Kafka guarantees atomic transactions, which powers the applications to produce to multiple TopicPartitions atomically. All writes to these TopicPartitions will either succeed or fail as a single unit. The application must provide a unique id, TransactionalId, to the producer which is stable across all sessions of the application.

There is a 1-1 mapping between TransactionalId and PID. Kafka promises exactly one active producer with a given TransactionalId by baring off the old instance when new with same TransactionalId is alive. Kafka also guarantees that the new instance is in the pure state by ensuring that all unfinished transactions have been completed(aborted/committed).

The size of the older message format is fixed at 34 bytes. The new message format needed an addition of PID, Epoch and Sequence number which also added a significant overhead in the message size with 53 byte

Under the covers it works in a way similar to TCP; each batch of messages sent to Kafka will contain a sequence number which the broker will use to dedupe any duplicate send. Unlike TCP, though—which provides guarantees only within a transient in-memory connection—this sequence number is persisted to the replicated log, so even if the leader fails, any broker that takes over will also know if a resend is a duplicate.

```java
producer.initTransactions();
try {
  producer.beginTransaction();
  producer.send(record1);
  producer.send(record2);
  producer.commitTransaction();
} catch(ProducerFencedException e) {
  producer.close();
} catch(KafkaException e) {
  producer.abortTransaction();
}

```

set a producer config “transactional.id” to some unique ID. This unique ID is needed to provide continuity of transactional state across application restarts.

transaction coordinator (which manages the transaction state per producer) runs within the broker and naturally leverages Kafka’s leader election algorithm to handle failover.

We solve the problem of zombie instances by requiring that each transactional producer be assigned a unique identifier called the transactional.id. This is used to identify the same producer instance across process restarts.

The API requires that the first operation of a transactional producer should be to explicitly register its transactional.id with the Kafka cluster. When it does so, the Kafka broker checks for open transactions with the given transactional.id and completes them. It also increments an epoch associated with the transactional.id. The epoch is an internal piece of metadata stored for every transactional.id.

Further, a given consumer is not guaranteed to be subscribed to all partitions which are part of a transaction, and it has no way to discover this, making it tough to guarantee that all the messages which were part of a single transaction will eventually be consumed by a single consumer.

The transaction coordinator is a module running inside every Kafka broker. The transaction log is an internal kafka topic. Each coordinator owns some subset of the partitions in the transaction log, ie. the partitions for which its broker is the leader.

Every transactional.id is mapped to a specific partition of the transaction log through a simple hashing function. This means that exactly one coordinator owns a given transactional.id.

It is worth noting that the transaction log just stores the latest state of a transaction and not the actual messages in the transaction. The messages are stored solely in the actual topic-partitions. The transaction could be in various states like “Ongoing,” “Prepare commit,” and “Completed.” It is this state and associated metadata that is stored in the transaction log.


When executing transactions, the producer makes requests to the transaction coordinator at the following points:

The initTransactions API registers a transactional.id with the coordinator. At this point, the coordinator closes any pending transactions with that transactional.id and bumps the epoch to fence out zombies. This happens only once per producer session.
When the producer is about to send data to a partition for the first time in a transaction, the partition is registered with the coordinator first.
When the application calls commitTransaction or abortTransaction, a request is sent to the coordinator to begin the two phase commit protocol.

The transaction coordinator is the only component to read and write from the transaction log.

If a given broker fails, a new coordinator is elected as the leader for the transaction log partitions the dead broker owned, and it reads the messages from the incoming partitions to rebuild its in-memory state for the transactions in those partitions.

After the producer initiates a commit (or an abort), the coordinator begins the two phase commit protocol.

In the first phase, the coordinator updates its internal state to “prepare_commit” and updates this state in the transaction log. Once this is done the transaction is guaranteed to be committed no matter what.

The coordinator then begins phase 2, where it writes transaction commit markers to the topic-partitions which are part of the transaction.

These transaction markers are not exposed to applications, but are used by consumers in read_committed mode to filter out messages from aborted transactions and to not return messages which are part of open transactions (i.e., those which are in the log but don’t have a transaction marker associated with them).

Once the markers are written, the transaction coordinator marks the transaction as “complete” and the producer can start the next transaction.

The transactional.id plays a major role in fencing out zombies. But maintaining an identifier that is consistent across producer sessions and also fences out zombies properly is a bit tricky.

The key to fencing out zombies properly is to ensure that the input topics and partitions in the read-process-write cycle is always the same for a given transactional.id. If this isn’t true, then it is possible for some messages to leak through the fencing provided by transactions.

Practically, one would either have to store the mapping between input partitions and transactional.ids in an external store, or have some static encoding of it. Kafka Streams opts for the latter approach to solve this problem.

First, transactions cause only moderate write amplification. The additional writes are due to:

For each transaction, we have had additional RPCs to register the partitions with the coordinator. These are batched, so we have fewer RPCs than there are partitions in the transaction.
When completing a transaction, one transaction marker has to be written to each partition participating in the transaction. Again, the transaction coordinator batches all markers bound for the same broker in a single RPC, so we save the RPC overhead there. But we cannot avoid one additional write to each partition in the transaction.
Finally, we write state changes to the transaction log. This includes a write for each batch of partitions added to the transaction, the “prepare_commit” state, and the “complete_commit” state.

The main tradeoff when increasing the transaction duration is that it increases end-to-end latency. Recall that a consumer reading transactional messages will not deliver messages which are part of open transactions. So the longer the interval between commits, the longer consuming applications will have to wait, increasing the end-to-end latency.

the consumer does not need to any buffering to wait for transactions to complete. Instead, the broker does not allow it to advance to offsets which include open transactions.

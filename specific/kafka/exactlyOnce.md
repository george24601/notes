Alternatively, this will also work if the sink is idempotent. In fact, if our processing stages are idempotent, we don’t really need any of the additional exactly-once features: at-least-once is good enough.

Note that enable.idempotence must be enabled if a TransactionalId is configured.

We solve the problem of zombie instances by requiring that each transactional producer be assigned a unique identifier called the transactional.id. This is used to identify the same producer instance across process restarts.

There is a 1-1 mapping between TransactionalId and PID. Kafka promises exactly one active producer with a given TransactionalId by baring off the old instance when new with same TransactionalId is alive. Kafka also guarantees that the new instance is in the pure state by ensuring that all unfinished transactions have been completed(aborted/committed).

The size of the older message format is fixed at 34 bytes. The new message format needed an addition of PID, Epoch and Sequence number which also added a significant overhead in the message size with 53 byte

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

Further, a given consumer is not guaranteed to be subscribed to all partitions which are part of a transaction, and it has no way to discover this, making it tough to guarantee that all the messages which were part of a single transaction will eventually be consumed by a single consumer.

The transaction coordinator is a module running inside every Kafka broker. The transaction log is an internal kafka topic. Each coordinator owns some subset of the partitions in the transaction log, ie. the partitions for which its broker is the leader.
Every transactional.id is mapped to a specific partition of the transaction log through a simple hashing function. This means that exactly one coordinator owns a given transactional.id.

When executing transactions, the producer makes requests to the transaction coordinator at the following points:

The initTransactions API registers a transactional.id with the coordinator. At this point, the coordinator closes any pending transactions with that transactional.id and bumps the epoch to fence out zombies. This happens only once per producer session.
When the producer is about to send data to a partition for the first time in a transaction, the partition is registered with the coordinator first.

The key to fencing out zombies properly is to ensure that the input topics and partitions in the read-process-write cycle is always the same for a given transactional.id. If this isn’t true, then it is possible for some messages to leak through the fencing provided by transactions.

Practically, one would either have to store the mapping between input partitions and transactional.ids in an external store, or have some static encoding of it. Kafka Streams opts for the latter approach to solve this problem.

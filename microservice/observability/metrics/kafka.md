The check collects metrics via JMX, so you’ll need a JVM on each kafka node so the Agent can fork jmxfetch. You can use the same JVM that Kafka uses.

The Kafka Integration uses Datadog’s JMXFetch application to pull metrics, just like our other Java based applications such as Cassandra, JMX, Tomcat, etc. This pulls metrics through the use of mBeans, where the engineering team has included a list of commonly used mBeans in the Kafka.yaml file.

This means that Kafka brokers are stateless—they do not track consumption, leaving message deletion to a configurable retention policy.

Though numerous replicas may exist, Kafka will only initiate the write on the leader of a partition, elected randomly from the pool of in-sync replicas. Additionally, consumers will only read from a partition leader. Thus, follower replicas serve as a fallback (so long as they remain in-sync) to maintain high availability in the event of broker failure.

ZooKeeper is the glue that holds it all together, and is responsible for:

electing a controller (Kafka broker that manages partition leaders)
recording cluster membership
topic configuration
quotas (0.9+)
ACLs (0.9+)
note consumer group membership info is NO LONGER in ZK

#Broker Metrics

LeaderElectionRateAndTimeMs metric to report the rate of leader elections (per second) and the total time the cluster went without a leader (in milliseconds).

Keeping an eye on the size of the request purgatory is useful to determine the underlying causes of latency. Increases in consumer fetch times, for example, can be easily explained if there is a corresponding increase in the number of fetch requests in purgatory.

The TotalTimeMs metric family measures the total time taken to service a request (be it a produce, fetch-consumer, or fetch-follower request).

Under normal conditions, this value should be fairly static, with minimal fluctuations. If you are seeing anomalous behavior, you may want to check the individual queue, local, remote and response values to pinpoint the exact request segment that is causing the slowdown.

These values are monitored via three counters on the dashboard: consumer fetch time, produce request time, and follower fetch time.

This counter monitors the difference between the reported values of IsrShrinksPerSec and IsrExpandsPerSec. The number of in-sync replicas (ISRs) should remain fairly static, the only exceptions are when you are expanding your broker cluster or removing partitions.

This counter monitors when partition replicas fall too far behind their leaders and the follower partition is removed from the ISR pool, causing a corresponding increase in IsrShrinksPerSec.

This counter monitors the number of partitions without an active leader.  A non-zero value for this metric should be alerted on to prevent service interruptions. Any partition without an active leader will be completely inaccessible, and both consumers and producers of that partition will be blocked until a leader becomes available.

#producer metrics
This graph represents the percentage of time the CPU is idle and there is at least one I/O operation in progress. If you are seeing excessive wait times, it means your producers can’t get the data they need fast enough.

This graph monitors the rate of messages consumed per second, which may not strongly correlate with the rate of bytes consumed because messages can vary in size.

Monitoring this metric over time can help you discover trends in your data consumption and create baselines against which you can alert.

Min fetch rate

This graph measures the fetch rate of a consumer, which can be a good indicator of overall consumer health.

ParNew time by broker
The young generation garbage collections monitored by this graph pause all application threads during garbage collection.

CMS time by broker
The ConcurrentMarkSweep (CMS) metric monitors the collections that free up unused memory in the old generation of the heap.

#consumer metrics

ConsumerLag/MaxLag measures the difference between a consumer’s current log offset and a producer’s current log offset.MaxLag goes hand-in-hand with ConsumerLag, and is the maximum observed value of ConsumerLag.

MinFetchRate: In a healthy consumer, the minimum fetch rate will usually be non-zero, so if you see this value dropping, it could be a sign of consumer failure.


#ZooKeeper metrics.

zk_outstanding_requests: Clients can end up submitting requests faster than ZooKeeper can process them.
Because each broker must maintain a connection with ZooKeeper, and each connection to ZooKeeper uses multiple file descriptors, after increasing the number of available file descriptors in your ZooKeeper ensemble, you should keep an eye on them to ensure they are not exhausted.
You should be aware of unanticipated drops in this value; since Kafka uses ZooKeeper to coordinate work, a loss of connection to ZooKeeper could have a number of different effects, depending on the disconnected client

zk_pending_syncs (leader only): ZooKeeper must sync transactions to disk before returning a response, thus a large number of pending syncs will result in latencies increases across the board.
 This graph monitors the transaction log, which is the most performance-critical part of ZooKeeper. You should definitely monitor this metric and consider alerting on larger (> 10) values

zk_open_file_descriptor_count: ZooKeeper maintains state on the filesystem, with each znode corresponding to a subdirectory on disk. By default, most Linux distributions ship with a meager number of available file descriptors. After configuring your system to increase the number of available file descriptors, you should keep an eye on them to ensure they are not exhausted.



### survey on how to work with cross dc with different framework/techs

Kafka's schema registry: backup SR points to master DC's ZK and kafka, with it master set to false. Master DC is MMed to into the back up DC
In case DC A failed, we switch that SR to DC B, with master set to true. Note schema is immutable, and identified with only (name, version)

(To defend against failure/error, need parallel processing of all data too, and know how to hard switch)

Pattern 1: streched cluster: 
1. deploy zk and broker across 3 AZs
2. intra-cluster replication to replicate data across DCs
3. On failure, consumer/producer fail over to new DCs
4. When DC comes back, auto re-replicates all missing data
BUT THIS IS NOT RECOMMENDED across regions : 
bad case for assymmetric network partitioning
longer network latency
kafka has problem with across region bandwidth

pattern 2: active-passive
1.producer in active DC, consumer in either active or passive DC
2.Offset not identical across clusters! 
3.Resume from smallest offset vs largest offset -> largest offset means missing data, probably ok to real-time consumers
4.and when primary comes back, need to reverse mirroring => hard problem again!

Note hot standby may have window of data loss at failures, e.g., mysql binlog, i.e., stronger consistency, higher latency

pattern 3: active-active
1. each DC has both local and aggregate cluster. 
2. producer only write to local clusters. Producer/consumer in both DCs
3. When DC comes back, no need to reconfigure MM

active-active only means we can accept writes in multi-dc, and resolve conflicts, e.g., vector clock, 2PC, Paxos....

Alternative: avoid aggregate clusters
1. prefix topic names with DC tag
2. config MM to mirror remote topic only
3. consumer need to sub to topics with both DC tags

More DCs-> better resource utilization
With 3 DCs, each DC only needs to provision 50% traffic => only set up aggregate clusters in 2-3

Challenge: need to make sure multi-dc stragetgy is consistent with other data stores
Problem: need to make computed data avaialbe in all DCs
Ideas
1. active-active: no failover required
2. action-passive stretched db across DCs, only run one consumer per DC at any given point of time

Other consideration
1. enable SSL in MM, to safely transfer data cross DC
2. Run MM close to target cluster

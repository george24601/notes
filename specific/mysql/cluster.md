MySQL Cluster is implemented through the NDB or NDBCLUSTER storage engine for MySQL ("NDB" stands for Network Database).

Internally MySQL Cluster uses synchronous replication through a two-phase commit mechanism in order to guarantee that data is written to multiple nodes upon committing the data. (This is in contrast to what is usually referred to as "MySQL Replication", which is asynchronous.)

Two copies (known as replicas) of the data are required to guarantee availability. MySQL Cluster automatically creates “node groups” from the number of replicas and data nodes specified by the user.

Updates are synchronously replicated between members of the node group to protect against data loss and support fast failover between nodes.

It is also possible to replicate asynchronously between clusters; this is sometimes referred to as "MySQL Cluster Replication" or "geographical replication". This is typically used to replicate clusters between data centers for disaster recovery or to reduce the effects of network latency by locating data physically closer to a set of users. Unlike standard MySQL replication, MySQL Cluster's geographic replication uses optimistic concurrency control and the concept of Epochs to provide a mechanism for conflict detection and resolution

Data within MySQL Cluster (NDB) tables is automatically partitioned across all of the data nodes in the system. This is done based on a hashing algorithm based on the primary key on the table, and is transparent to the end application.

MySQL Cluster maintains all indexed columns in distributed memory. Non-indexed columns can also be maintained in distributed memory or can be maintained on disk with an in-memory page cache. Storing non-indexed columns on disk allows MySQL Cluster to store datasets larger than the aggregate memory of the clustered machines.

The core database exposes an ordered key-value store with transactions.[5] The transactions are able to read or write multiple keys stored on any machine in the cluster while fully supporting ACID properties

 Transactions can span multiple keys stored on multiple machines.

 An example is their SQL layer

 FoundationDB does not support transactions running over five seconds.

 Keys cannot exceed 10 kB in size. Values cannot exceed 100 kB in size

 Collectively, our metadata store is miniscule in size when compared to the warehoused data of our customers. The read and write patterns of our metadata are more akin to online transaction processing (OLTP) than usage patterns of an analytic data warehouse or online analytical processing system (OLAP) that is Snowflake

However, it could gain only a couple major customers (Snowflake Computing and Wavefront) before getting acquired by Apple in March 2015

 FoundationDB takes a very different approach in this regard. Instead of using a distributed consensus protocol for data replication, it follows a custom leaderless replication protocol that commits writes to ALL replicas (aka the transaction logs) before the client is acknowledged.

 conflicting transactions fail at commit time and have to be retried by the client.

 Since the transaction logs and storage servers maintain conflict information for only 5 seconds and entirely in memory, so any long-running transaction exceeding 5 seconds will be forced to abort. Another limitation is that any transaction can have a max of 10MB of affected data.

 Given its ability to serve data off SSDs fast and that too with compression enabled, Facebook’s RocksDB LSM storage engine is increasingly becoming the standard among modern databases.

A well-documented and reproducible Kubernetes deployment for FoundationDB is officially still a work-in-progress. One of the key blockers for such a deployment is the inability to specify hosts using hostname as opposed to IP. Kubernetes StatefulSets create ordinal and stable network IDs for their pods making the IDs similar to hostnames in the traditional world. 

the core engine seemingly favors the approaches highlighted in architecturally-limiting database designs such as Yale’s Calvin (2012) and Google’s Percolator (2010)

different consistency level read needed?

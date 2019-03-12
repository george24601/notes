To determine which database (DB) instance in an Aurora DB cluster a connection is connected to, you need to check the innodb_read_only global variable.
```
SHOW GLOBAL VARIABLES LIKE 'innodb_read_only'; 
```
The innodb_read_only variable will be set to ON if you are connected to an Aurora Replica and OFF if you are connected to the primary instance.

Use an Aurora DB cluster endpoint address when referencing your DB cluster. In the event of a failover, the replica promoted as the DB cluster’s primary instance will keep using that endpoint address.

Maintain all binlogs on your master instance until verifying they’ve been applied to the replica. This helps to make sure you’ll be able to restore the master instance if there’s a failure.

A known issue when an Aurora DB cluster is in the replication slave is that it might pause without warning. As a result, the CloudWatch ReplicaLog will keep growing. If this happens, you need to restore the cluster from its most recent snapshot and set up a replication of the restored cluster as the new replication slave.

When setting up a replication between MySQL DB instances and an Aurora DB cluster, the replication isn’t managed by RDS. You need to proactively monitor it to make sure it stays healthy and make repairs as necessary.

We recommend that you do not use multi-threaded replication in production. If you do use multi-threaded replication, we recommend that you test any use thoroughly.

 You can monitor how far an Aurora Replica is lagging behind the primary instance of your Aurora DB cluster by monitoring the Amazon CloudWatch ReplicaLag metric. Because Aurora Replicas read from the same cluster volume as the primary instance, the ReplicaLag metric has a different meaning for an Aurora DB cluster. The ReplicaLag metric for an Aurora Replica indicates the lag for the page cache of the Aurora Replica compared to that of the primary instance.

If you need the most current value for Aurora Replica lag, you can query the mysql.ro_replica_status table in your Aurora DB cluster and check the value in the Replica_lag_in_msec column. This column value is provided to Amazon CloudWatch as the value for the ReplicaLag metric. The values in the mysql.ro_replica_status are also provided in the INFORMATION_SCHEMA.REPLICA_HOST_STATUS table in your Aurora DB cluster.

The Amazon RDS launch wizard also created a route table in our VPC and configured it to route nonlocal
network traffic to the Internet gateway

From My Experience
--------
Replica lag: around 20 ms. Note that you can monitor how far an Aurora Replica is lagging behind the primary instance of your Aurora DB cluster by monitoring the Amazon CloudWatch ReplicaLag metric. Because Aurora Replicas read from the same cluster volume as the primary instance, the ReplicaLag metric has a different meaning for an Aurora DB cluster. The ReplicaLag metric for an Aurora Replica indicates the lag for the page cache of the Aurora Replica compared to that of the primary instance.

Even with multi-az deployment, each az gets only 1 instance,e.g., if i have only 2 az, then one az will get the writer, and the other reader. 

Crash dispatcher on writer:
master: create db instance
read slave: Read replica has been disconnected from master. Restarting Mysql. => create db instance

Crash instance on writer:

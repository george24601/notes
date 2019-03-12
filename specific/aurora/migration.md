One thing that we had to keep in mind was that there could be data inconsistency between MySQL and Aurora if new data is written between the time we migrated the data and the time we switched the connected database. We avoided this data inconsistency by temporarily stopping application use but not stopping the authentication function. We decided to announce a maintenance time, make the MySQL database read-only during that time (keeping authentication active), and migrate the data in that window. 

---------

Step 1: Make read replicas of MySQL and stop that replication to prevent the binary log from being deleted.

Step 2: Start Aurora.

Step 3: Construct replication with MySQL as master and Aurora as slave.

Step 4: Switch MySQL to read only, temporarily disabling some functions.

Step 5: Switch the access point to Aurora, application by application. Once the switch is made, all functions become active again.

Step 6: Stop MySQL.

In case of an error, we took a snapshot right after switching to read-only in step 4. From step 5, data writing to Aurora began. If a major problem occurred and forced us to fall back on MySQL, we would need to abandon the data written to Aurora since the beginning of step 5. We made the decision not to go back after step 5 even if a problem occurred.


Using MySQL Dump
This is the best suited method to migrate data from MySQL to the Aurora DB cluster if the data size exceeds 6 TB.
mysqldump utility is used to create MySQL data dump file. The dump file is then imported into the Aurora DB cluster so as to migrate the data to the Aurora DB cluster.


Using Amazon RDS MySQL DB Snapshot
This is the best suited method to migrate data from MySQL to the Aurora DB cluster if the data size is less than 6 TB. It is easy to migrate data from different regions such as ap-northeast-1, ap-northeast-2, ap-south-1, and so on by just taking a DB snapshot. The DB snapshot of an Amazon RDS MySQL DB instance is taken and the data is migrated into the Aurora DB cluster.

Using Amazon AWS Database Migration Service (AWS DMS)
AWS Database Migration Service, a web service, is used to easily and securely migrate data between heterogeneous or homogenous databases such as on-premises databases, RDS database, SQL, NoSQL, text based targets, and so on in zero downtime. It is also used for continuous data replication with high-availability.

This service is a low-cost service and allows you to pay only for the resources used and other additional log storage. AWS DMS is connected with MySQL so as to load data from MySQL to the Aurora DB cluster.

We didn’t migrate all of the 5TB of data to Amazon Aurora all at once. Instead, there were three significant steps that we broke down and split up into 14 tangible steps, and little by little we completed the system upgrade.

######

The first is that Aurora is MySQL compatible and supports being both a master and a slave. This functionality enabled us to move to Aurora with zero downtime. All that we had to do was create the Aurora cluster and make it a slave to our existing MySQL cluster. After replication had caught up, we changed the DNS record to point our application at Aurora instead of our MySQL clusters. We did have to do this for each of our services and MySQL clusters, but the process was very simple.

We set Aurora up as a slave of our on premise database using the mysql.rds_set_external_master stored procedure available in Aurora. This tool read and parsed the replication coordinates from the Xtrabackup log line mentioned earlier.

######
Next, we created a script to “flip” database masters between our datacenter and Aurora. This script has a few main objectives:

Update DNS records to reflect the new master (in multiple zones)
Ensure no writes can happen on the old master (read-only mode)
Ensure the new master can accept writes
Be able to “flip” back and forth from Aurora/on premise
Most importantly: ensure no data loss

Read-only mode
Since Aurora’s master/root database user does not have SUPER privileges, we could not modify global variables such as READ_ONLY . To work around this, we switched out the security group on the Aurora cluster to be a temporary restricted group that only the host running the script could access, which has the same effect on our applications.
“Assassinating” processes
One of the key steps in MHA is to kill running MySQL connections (in our case, using pt-kill) after a short wait once the former master has gone read-only. This requires SUPER privileges, too. We worked around this by running pt-kill for each user that shows up in the process list while connected as that user.


The process that our replication “flip” script used looks roughly like this, given that A is the on premise master and B is the Aurora master:

Flush tables on A
Set both A and B to read-only
Kill all processes on A
Flush tables on A
Wait for replication to be in sync between A and B
Stop the slave on B
Switch DNS records to reflect B as the master
Unset read-only on B
Reset slave on A
Change master on A to B, start slave
Reset slave on B




AWS Database Migration Service

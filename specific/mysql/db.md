### How to migrate for sharded db

* Maintanence window
  * write a program to read from the old db and to the new dbs
  * Verify consistency, and then swtich traffic
* Double write
  * Migrate historical data first
  * When writing to test_db, write the sql to the MQ (or via binlog replication)
  * have a migration program that migrate from db-old to db_new with id LT the max id pre-defined
  * migrate queueed data into the new db
  * Verify the consistency, remove double write code, and then point to the new db
  * Note need to handle deletion and udpate carefully

Partitioned table number needs to be 2^N, because when we mod, if you want to partition again, this can reduce the impact?!

### Another migration approach
1. virtual IP to the original master
2. give another virtual IP to both old and new
3. change the config to point to the new, restart the service
4. restart the service
5. change double virtual ip to single virtual IP, cut off the double sync
6. add new HA replica to the new dbs
7. purge stale data

### testOnBorrow

To prevent (actually only lower the risk) getting an invalid connection from the pool a solution seems to be the configuration of connections validation. Validating a connection means to run a very basic query on the database (e.g. SELECT 1; on MySQL).

Tomcat JDBC Connection Pool offers several options to test the connection. The two I find the more interesting are testOnBorrow and testWhileIdle.

First I was thinking that testOnBorrow is the best option because it basically validate the connection before providing it to the application (with a max frequency defined by validationInterval).

But after a second though I realized that testing the connection right before using it might impact the responsiveness of the application. So I though that using testWhileIdle can be more efficient as it test connections while they are not used.

Most of the times, testOnBorrow is the least risky since it ensures (as best it can) that before a connection is returned from the pool for your use, a basic sanity check has been made that the client and db-server are on talking terms.

ID generaion:
* GUID
* Snowflake

Sharding:
* range based: hot slice problem
* Hash based: what if you need range scan

### How to migrate if you want to increase db capacity:
1. add slave db to the real master, and sync
2. change sharding rule to include reads from the new shards
3. remove the master-slave sync
4. later on you can remove the redundant data

### Multi region
Every region has a shard, every shard better guarantee only one place to write, avoid double write

Need leader election between shards to decide who is the write master

Mysql's own repliation is normally not reliable, self-made a DRC, e.g., DTS on alicloud (based on otter + canal)


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

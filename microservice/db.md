ID generaion:
* GUID
* Snowflake

Sharding:
* range based: hot slice problem
* Hash based: what if you need range scan

Increase capacity:
1. add slave db to the real master, and sync
2. change sharding rule to include reads from the new shards
3. remove the master-slave sync
4. later on you can remove the redundant data

### Multi region
Every region has a shard, every shard better guarantee only one place to write, avoid double write

Need leader election between shards to decide who is the write master

Mysql's own repliation is normally not reliable, self-made a DRC, e.g., DTS on alicloud (based on otter + canal)


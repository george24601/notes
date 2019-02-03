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


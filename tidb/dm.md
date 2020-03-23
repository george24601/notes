DM supports full backup to tidb, and analyze binlog to sync incremental to tidb

components: 
dm master: 
dm worker: 1-1 mapping with upstream mysql instance
dm ctl: communicates to dm master

for incremental, implemented by relay and syncer, part of binlog replication

relay acts as a slave to upstream mysql,and persist the relay log locally. Note this persisted relay log can allow multiple syncers to share

mydumper uses --chunk-filesize to partition a snapshot of tables into mutliple independent files

syncer will analyze the binlog event, create jobs, and send to mutliple waiting job channels
Catchs: 
* DDL handling
* concurrent DML conflict detection - need to check tidb-binlog architecture, on the implmentation of the drainer

DM supports filtering by Binlog events, check binlog-filter pkg

binlog has to be RBR, which is recommended after mysql 5.7

source_id is the identifier for for database instance. This should not be changed during 
server_id: a unique id in the upstream mysql cluster, since DM worker as as a slave

relay_binlog_name and relay_binlog_gtid: normally we don't need to config it (?). By default DM pulls from the start

task-mode: "all": full + incremental

then use dm-ctl to start the task, also use it to check the task status






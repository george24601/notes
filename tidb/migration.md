mysql dump 4-5G per min
loader 28G/h lightining 150-200G/h
DM supports both full data migration and delta migration, DM uses loader instead of TiDB lightning?

DM will filter certain binlog event, e.g., drop, truncate table

loader will use a by default tidb_loader db as checkpoint db

note lighting is faster for full import - 7 hours for 1 TB

lightning -> tikv importer, which talks to the PD server, note that tidb-lightening does not talk to PD directly

lightning and importer are resource intensive, recommend two separate servers

Data migration is the next gen syncer for delta migration


* try to limit mydumper file to 64MB

### reparo

replicate-do-db specifies the database for recovery. If it is not set, all the databases are to be recovered.
replicate-do-table specifies the table for recovery. If it is not set, all the tables are to be recovered.

The data exported from MySQL contains a metadata file which includes the position information
The position information (Pos: 930143241) needs to be stored in the syncer.meta file for syncer to synchronize:
The syncer.meta file only needs to be configured once when it is first used. The position will be automatically updated when binlog is synchronized.

```syncer toml

log-level = "info"
log-file = "syncer.log"
log-rotate = "day"

server-id = 101

meta = "./syncer.meta"
worker-count = 16
batch = 1000
flavor = "mysql"

# The testing address for pprof. It can also be used by Prometheus to pull Syncer metrics.
status-addr = ":8271"

# If you set its value to true, Syncer stops and exits when it encounters the DDL operation.
stop-on-ddl = false

# max-retry is used for retry during network interruption.
max-retry = 100
```


###mydumper output
1. metadata: start, end time, and binlog file postions
2. table data: every table has a file
3. table schemas
4. binary logs under binlog_snapshot



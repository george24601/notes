note lighting is faster for full import - 7 hours for 1 TB

lightning -> tikv importer, which talks to the PD server, note that tidb-lightening does not talk to PD directly

lightning and importer are resource intensive, recommend two separate servers

Data migration is the next gen syncer for delta migration

TiDB lightning is only for tidb, seems only ansible deployemnt is possible?

TiDB and lightning have native checksum functionality
how is checkpoint is used? but importer restart has limited automated support

DM supports both full data migration and delta migration, DM uses loader instead of TiDB lightning?

DM will filter certain binlog event, e.g., drop, truncate table
dm is on ansible too?!

tidb-binlog, relationship with data management

### loader
1. loader will use a by default tidb_loader db as checkpoint db
2. 


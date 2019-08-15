One significant difference is blob types are stored in secondary storage, while varbinaries are stored inline in the row in the same way as varchars and other "simple" types.

service_id: last bit(byte?) in the IP address + current mysql service's port # - make sure they are different on master and slave

TRUNCATE will reset the auto-incrementing column!

wait_timeout and interactive_timeout: default 8 hours, after that MySql will close the connection to recycle the resource

use `perror` to see the error log

open_files_limit: maybe too small

UNION vs UNION ALL

IN vs EXISTS: IN outer big, inner small; EXISTS outer small inner big

Avoid null check in where => may lead to FTS instead of index scan , note that null compares with anything is null

Use forceindex, STRAIGHT_JOIN to tweak query plan

Change buffer???

prefer timestamp to datetime?
prefer IN to OR? limit size of IN to 200

Innodb uses old and young for separate LRU, young for hot, old for cold. They meet at midpoint. If the data point exists in oldLRU for more than 1 sec, move to young

### Debug slow query
lock problem: `show processlist`
cadinality is done by sampling and predicting , see if  you can use `force index(a)` clause , and use `show index from t` to see if index data matches the reality

may consider using UNION instead of OR, because OR may trigger FTS. `idx_col IS NULL OR idx_col = val` often triggers full table scan

why do you need undo log (for A?)
why do you need redo log (optimization for D, to improve on random write?)

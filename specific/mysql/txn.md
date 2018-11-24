redo log: commited txn's ACID, log change to redo log
undo log: insert: record PK(ROW_ID), deetel/update: record old data row, note these two cases are in two different buffers
rollback segment: store undo log. On commit, this undo log can be deleted

for every row:
DB_TRX_ID: 6 bytes:  every row's most recent txn id
DB_ROLL_PTR: 7 bytes: pointer to the underlog
DB_ROW_ID: 6 bytes, monotonically increasing row ID

Old version data is stored in rollback segment

Snapshot read means Consistent nonlocking read on the rollback segment, i.e., historical snapshot

normal select read is always snapshot read, unless explicitly ask for locking, RR reads on a fixed version though


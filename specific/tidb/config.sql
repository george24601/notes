set global tidb_hashagg_final_concurrency=1;
set global tidb_hashagg_partial_concurrency=1;
set global tidb_disable_txn_auto_retry=0;

select VARIABLE_NAME, VARIABLE_VALUE from mysql.tidb;

update mysql.tidb set VARIABLE_VALUE='2h0m' where VARIABLE_NAME='tikv_gc_run_interval';

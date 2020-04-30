--check current binlog position, use it to set syncer init position (just need it for the first time)
show master status

--to see if SCATTERING col is all 0
SHOW TABLE test_hospot REGIONS 

--most recent slow query
SELECT Time, Query
FROM information_schema.slow_query
ORDER BY Time DESC LIMIT 10;

SELECT Time, query_time, Query
FROM information_schema.slow_query
WHERE TIME >= '2020-03-15 07:27:00' and query_time > 1
ORDER BY TIME ASC
LIMIT 3

SELECT COUNT(*) FROM txn_history use index (idx_transaction_history) WHERE user_id = '29619963' AND (order_created_at between '2018-10-01 00:00:00' and '2020-03-15 07:27:16.779') AND (true = 1 OR peer_id = 'null') AND (true = 1 OR txn_type IN ('DEFAULT')) AND (true = 1 OR payment_methods IN (0)) AND (true = 1 OR order_state IN ('COMPLETED')) AND disabled <= 0 ORDER BY txn_id desc

SELECT count(*) FROM txn_history use index (idx_transaction_history) WHERE user_id = '28783992' AND (order_created_at between '2020-01-01 00:00:00' and '2020-03-15 07:27:12.639') AND (true = 1 OR peer_id = 'null') AND (true = 1 OR txn_type IN ('DEFAULT')) AND (true = 1 OR payment_methods IN (0)) AND (true = 1 OR order_state IN ('COMPLETED')) AND disabled <= 0 ORDER BY txn_id desc

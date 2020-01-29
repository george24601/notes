--to see if SCATTERING col is all 0
SHOW TABLE test_hospot REGIONS 

SELECT Time, Query
FROM information_schema.slow_query
WHERE TIME >= '2020-01-22 23:30:00' AND TIME <= '2020-01-23 01:00:00' 
LIMIT 50

SELECT Time, query_time, Query
FROM information_schema.slow_query
WHERE TIME >= '2020-01-23 20:00:00'
LIMIT 50


--WHERE TIME >= '2020-01-22 23:00:00' AND TIME <= '2020-01-23 00:00:00'

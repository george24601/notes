You can tune random_page_cost to influence the point where a sequential scan is chosen. If you have SSD storage, you should set the parameter to 1.0 or 1.1 to tell PostgreSQL that index scans are cheaper on your hardware.

PostgreSQL uses a cost based optimizer, not a rule based optimizer. If you take the estimated cost of the index scan, 18693, and scale it up linearly by the ratio of the expected rows between the two plans (which is not exactly what the planner does, but should be a good enough first approximation) you get 22330. That is higher than the expected cost of the seq scan, 21372, so it chooses the seq scan.

One component of the statistics is the total number of entries in each table and index, as well as the number of disk blocks occupied by each table and index. This information is kept in the table pg_class, in the columns reltuples and relpages. 

For efficiency reasons, reltuples and relpages are not updated on-the-fly, and so they usually contain somewhat out-of-date values. They are updated by VACUUM, ANALYZE, and a few DDL commands such as CREATE INDEX. A VACUUM or ANALYZE operation that does not scan the entire table (which is commonly the case) will incrementally update the reltuples count on the basis of the part of the table it did scan, resulting in an approximate value. 

The information used for this task is stored in the pg_statistic system catalog. Entries in pg_statistic are updated by the ANALYZE and VACUUM ANALYZE commands, and are always approximate even when freshly updated.

Rather than look at pg_statistic directly, it's better to look at its view pg_stats when examining the statistics manually. pg_stats is designed to be more easily readable. Furthermore, pg_stats is readable by all, whereas pg_statistic is only readable by a superuser

SELECT attname, inherited, n_distinct,
       array_to_string(most_common_vals, E'\n') as most_common_vals
FROM pg_stats
WHERE tablename = 'road';

The amount of information stored in pg_statistic by ANALYZE, in particular the maximum number of entries in the most_common_vals and histogram_bounds arrays for each column, can be set on a column-by-column basis using the ALTER TABLE SET STATISTICS command, or globally by setting the default_statistics_target configuration variable. The default limit is presently 100 entries. Raising the limit might allow more accurate planner estimates to be made, particularly for columns with irregular data distributions, at the price of consuming more space in pg_statistic and slightly more time to compute the estimates. Conversely, a lower limit might be sufficient for columns with simple data distributions.

->  Index Scan using data_area_pkey on data_area  (cost=0.00..52.13 rows=1 width=8) 
    (actual time=0.006..0.008 rows=0 loops=335130)

If you compute the total cost, considering loops, it is 52.13 * 335130 = 17470326.9. This is larger than 14857017.62 for the seq_scan alternative. That is why it does not use the index.

You should also check the correlation in pg_stats, that is used by the optimizer to assess clustering when computing the index cost, and finally try changing random_page_cost and cpu_index_tuple_cost, to match your system.

random_page_cost 
seq_page_cost
max_parallel_workers 
max_parallel_workers_per_gather

The index scan takes longer, but only because it is not parallelized. The sequential scan uses more total time, but since it is run on 5 cores in parallel, it finishes faster.

PostgreSQL v10 can perform parallel index scans, so the remaining riddle is why it doesn't. A side riddle is why the sequential scan uses so many parallel workers.

I suspect that you messed up the configuration parameters. The relevant parameters are:

max_parallel_workers_per_gather: limits how many workers can be used. You must have set this to 4 or more.

min_parallel_table_scan_size: if a table is bigger than that, a parallel worker is planned. If the table size exceeds 3n-1 times that value, n parallel workers are planned. So either your table is very big, or you reduced the parameter. Alternatively:

The storage parameter parallel_workers on the table overrides the calculation based on min_parallel_table_scan_size as described above, so maybe you set that.

Finally, min_parallel_index_scan_size governs when a parallel index scan is considered. Either the index is small, or you lowered the parameter.



When a query is executed, MySQL knows in which partitions the data may reside, so the query hits only these particular partitions. Note that you don’t want your queries to hit all the partitions. This would be a big performance problem that could degrade your system; a the worst-case scenario, when partitioning would not add any value to system performance. When queries are executed, they should hit the smallest number of partitions possible (just a subset of the whole data). To achieve this goal, you can rewrite your queries to fit the actual partitioning schema or create a better partitioning schema for your data.

In MySQL, all columns that are part of the partition key must present in every unique key of the table.

In order to improve the performance and scalability of the system, we can balance the IO workload by distributing the partitions in different disks/volumes. We can achieve this using the DATA DIRECTORY and INDEX DIRECTORY options of the PARTITION clause

There are several types of partitioning in MySQL such as:

RANGE
HASH
LIST
KEY

```
CREATE TABLE testing_db.sales_order (
    id int NOT NULL,
    product varchar(20) NOT NULL,
    created datetime NOT NULL,
    amount decimal(8,2),
    PRIMARY KEY(id, product, created)
)
PARTITION BY RANGE( YEAR(created) )
( PARTITION part_less_than_2015 VALUES LESS THAN (2015),
  PARTITION part_2015 VALUES LESS THAN (2016),
  PARTITION part_2016 VALUES LESS THAN (2017),
  PARTITION part_greater_than_2017 VALUES LESS THAN MAXVALUE
);
ALTER TABLE t1 ADD PARTITION (PARTITION p3 VALUES LESS THAN (2002));
```

In this way, the ranges should be contiguous but they cannot overlap each other.
This scheme is very useful for representing ranges of time for tracking, logging, recording transactions, etc.

You can verify that MySQL has actually created a data file for each partition by listing the testing_db database directory as shown in the listing 02



seems challenges with subquery and multiple joins

fact table is changed much more frequently than dimension tables

lack of delete/update may be an issue, so seems to fit offline analytics better

supports sortby when creating table - they will be stored in consecutive blocks

primary key is not used to dedup 

sparse index: stats on blocks rather than row

LSM tree: once the data is in hard if not possible to change

delete and update are async, need to see the effect after the compaction

alter table delete where filter_expr,alter table update col=val where filter_expr

pattern seems to be pre-joined wide table

low qps, limit it to within 100


Fengchao

sharded solution
grey by DBs

business and traffic replay

traffic replay via dbreplay to tidb, which sits on the nginx cluster

pump and drainer from mysql to tidb, and then tidb to old mysql master

timestamp based dbcompare 
read-write traffic grey at the same time, by the db, new data in tidb is synced back to mysql

failover to the aurora in case of most critical error

didn't switch read traffic or double write, direct migrate to tidb


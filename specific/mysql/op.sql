create database g_f;
create database g_t;

CREATE TABLE `t` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `vc` varchar(255) NOT NULL UNIQUE,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

insert into t (vc) VALUES("test")
insert into t (vc) VALUES("t1\nt1");
insert into t (vc) VALUES("t2\nt2");
insert into t (vc) VALUES("t3\nt3");

SHOW [SESSION | GLOBAL] STATUS
SHOW [SESSION | GLOBAL] variables
SHOW ENGINE INNODB STATUS
--see current statement's state
SHOW PROESSLIST
SHOW STATUS LIKE '%lock%'
slowlog 

-- cadinality is done by sampling and predicting , see if index data matches the reality
show index from t

#!/bin/bash
/sbin/service mysqld start

docker run -d --name mysql_database -e MYSQL_USER=user -e MYSQL_PASSWORD=pass -e MYSQL_DATABASE=db centos/mysql-57-centos7

docker run -d --name mysql_database -e MYSQL_USER=user -e MYSQL_DATABASE=db centos/mysql-57-centos7


docker run -d --name mysql_database -e MYSQL_USER=user -e MYSQL_PASSWORD=pass -e MYSQL_DATABASE=db centos/mysql-57-centos7


docker exec -it mysql_database bash

mysqladmin -h 127.0.0.1 -P 3306 -u root create test

mysql  06 -u user test

mysql  --user root -D test

#this works
mysql -u root -p 


mysqladmin -h 127.0.0.1 -P 3306 -u user -p pass \
       	create test


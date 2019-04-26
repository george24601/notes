#mount SSD volume
sudo su
lsblk
mkfs -t ext4 /dev/xvdb

yum install wget
wget https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
rpm -ivh mysql57-community-release-el7-11.noarch.rpm
yum install mysql
yum install mysql-server


#find temp password
grep 'temporary password' /var/log/mysqld.log

#change password
mysql -uroot -p

#once inside console, change password
#ALTER USER 'root'@'localhost' IDENTIFIED BY 'PASSWORD_HERE';

# test pw change
mysql -uroot -p "PASSWORD_HERE"

service mysqld stop
service mysqld status

sudo rsync -av /var/lib/mysql /mnt/mysql
#change config

vim /etc/my.cnf

<<NEWCONFIG
datadir=/mnt/mysql
socket=/mnt/mysql/mysql.sock

# Disabling symbolic-links is recommended to prevent assorted security risks
symbolic-links=0

#turn on mysql binlog
log-bin=/mnt/mysql-bin/binlog
log-error=/var/log/mysqld.log
pid-file=/var/run/mysqld/mysqld.pid

[client]
port=3306
socket=/mnt/mysql/mysql.sock
NEWCONFIG

#DONT FORGET SEUNX CONTEXT
semanage fcontext -a -s system_u -t mysqld_db_t "/mnt/mysql(/.*)?"
restorecon -Rv /mnt/mysql

service mysqld start
service mysqld status

<<NWACCESS
#otherwise can't connect other than localhost
GRANT ALL ON *.* to root@'%' IDENTIFIED BY 'PASSWORD_HERE';

FLUSH PRIVILEGES;
NWACCESS

####
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


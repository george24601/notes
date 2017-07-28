wget https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
#md5 should 
md5sum mysql57-community-release-el7-11.noarch.rpm

rpm -ivh mysql57-community-release-el7-11.noarch.rpm 

yum install mysql
yum install mysql-server
yum install mysql-devel 

export PATH=$PATH:/usr/bin/mysql

cd src ; make

mysqladmin create tpcc1000
mysql tpcc1000 < create_table.sql

tpcc_load -h 127.0.0.1 -d tpcc1000 -u root -p "" -w 1000

./tpcc_start -h 127.0.0.1 -P 3306 -d tpcc1000 -u root -w 1000 -c 32 -r 10 -l 10800

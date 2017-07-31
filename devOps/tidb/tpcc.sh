wget https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
#md5 should 
md5sum mysql57-community-release-el7-11.noarch.rpm

rpm -ivh mysql57-community-release-el7-11.noarch.rpm 

yum install mysql
yum install mysql-server
yum install mysql-devel 

export PATH=$PATH:/usr/bin/mysql

cd src ; make

#########

mysql -h 127.0.0.1 -P 4000 -u root -D test
#mysqladmin create tpcc1000
mysqladmin -h 127.0.0.1 -P 4000 -u root create tpcc1000

mysql  -h 127.0.0.1 -P 4000 -u root tpcc1000 < create_table.sql

mysql  -h 127.0.0.1 -P 4000 -u root tpcc1000 < add_fkey_idx.sql

#./tpcc_load -h server_host -P port -d database_name -u mysql_user -p mysql_password -w warehouses -l part -m min_wh -n max_wh
#* [part]: 1=ITEMS 2=WAREHOUSE 3=CUSTOMER 4=ORDERS

./tpcc_load -h 127.0.0.1 -P 4000 -d tpcc1000 -u root -p "" -w 1

./tpcc_start -h 127.0.0.1 -P 4000 -d tpcc1000 -u root -w 1 -c 1 -r 10 -l 20

./tpcc_start -h 127.0.0.1 -P 4000 -d tpcc1000 -u root -w 1 -c 1 -r 1 -l 20 \
       	-i 5 -f report.txt -t trx.txt


mysql -h 127.0.0.1 -P 4000 -u root -D tpcc1000


<<SAMPLEOUTPUT
   5, trx: 0, 95%: 67.917, 99%: 67.917, max_rt: 67.910, 0|61.593, 0|22.044, 0|0.000, 0|275.463
   errorno, sqlstate, error
   1265, 01000, Data Truncated

mysql  Ver 14.14 Distrib 5.7.19, for Linux (x86_64) using  EditLine wrapper
SAMPLEOUTPUT



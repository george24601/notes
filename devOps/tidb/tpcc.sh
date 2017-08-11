wget https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
#md5 should 
md5sum mysql57-community-release-el7-11.noarch.rpm

rpm -ivh mysql57-community-release-el7-11.noarch.rpm 

yum install mysql
yum install mysql-server
yum install mysql-devel 

export PATH=$PATH:/usr/bin/mysql

git clone https://github.com/pingcap/tidb-bench.git

cd src ; make

#########

mysql -h 127.0.0.1 -P 4000 -u root -D test
#mysqladmin create tpcc1000

mysql  -h 127.0.0.1 -P 4000 -u root tpcc1000 < create_table.sql

#may do that after poping data 
mysql  -h 127.0.0.1 -P 4000 -u root tpcc1000 < add_fkey_idx.sql

#./tpcc_load -h server_host -P port -d database_name -u mysql_user -p mysql_password -w warehouses -l part -m min_wh -n max_wh
#* [part]: 1=ITEMS 2=WAREHOUSE 3=CUSTOMER 4=ORDERS
#-r ramp_up_time -m measure time -c number connections

./tpcc_start -h  127.0.0.1  -P 4000 -d tpcc1000 -u root -w 1 -c 1 -r 10 -l 400

./tpcc_load -h 127.0.0.1 -P 4000 -d tpcc1000 -u root -p "" -w 1

./tpcc_start -h  127.0.0.1  -P 4000 -d tpcc1000 -u root -w 1 -c 1 -r 10 -l 40


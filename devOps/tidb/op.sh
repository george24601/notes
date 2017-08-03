wget http://download.pingcap.org/tidb-latest-linux-amd64.tar.gz
wget http://download.pingcap.org/tidb-latest-linux-amd64.sha256

sha256sum -c tidb-latest-linux-amd64.sha256

tar -xzf tidb-latest-linux-amd64.tar.gz

cd tidb-latest-linux-amd64


#On a blank centos
yum install wget
yum install vim
yum install mysql
yum install nc

###############
#Docker deployment
docker run -d -p 4000:4000 --name t1 -it t1 /bin/bash

docker exec -it t1 bash

docker exec -it centos bash

############
#Binary deployment
#start PD
./bin/pd-server --data-dir=pd \
	                --log-file=pd.log

#start TiKV
./bin/tikv-server --pd="127.0.0.1:2379" \
	                  --data-dir=tikv \
			                    --log-file=tikv.log

#start TiDB
./bin/tidb-server --store=tikv \
	                  --path="127.0.0.1:2379" \
			                    --log-file=tidb.log


#connect to TiDB
mysql -h 127.0.0.1 -P 4000 -u root -D test

nc -v 127.0.0.1 4000

######
#use dd to check disk performance
LANG='en_US.UTF-8' dd bs=4k count=250000 oflag=direct if=/dev/zero of=/home/ec2-user/deploy/io_test.txt 2>&1 | awk '/MB/{print $(NF-1)}'

lsblk
sudo dd if=/dev/xvda of=/dev/null bs=1M

dd bs=4k count=250000 conv=fsync if=/dev/zero of=/home/ec2-user/deploy/io_test.txt

LANG='en_US.UTF-8' dd bs=4k count=250000 oflag=direct if=/dev/zero of=/home/ec2-user/deploy/io_test.txt


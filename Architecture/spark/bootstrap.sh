sudo apt-get update
#or use openjdk
sudo apt-get install openjdk-7-jdk

#install spark
tar -xvf spark-1.2.1-bin-hadoop2.4.tgz
tar -xvf hadoop-2.6.0.tar.gz

#open all ports
sudo apt-get install ufw
sudo ufw enabled
sudo ufw allow 1:65535/tcp
sudo ufw allow 1:65535/udp

#spark master listening
sudo ufw allow 7077

#install hadoop
sudo apt-get install ssh

#hadoop name node listening
sudo ufw allow 8020

#hadoop resource node listening
sudo ufw allow 8031

#add mounting points to data nodes, spark recommends 4-8 mounting points, i.e,

sudo chmod 777 -R /mnt/disk1
mkdir /mnt/disk1/dn

sudo chmod 777 -R /mnt/disk2
mkdir /mnt/disk2/dn

sudo chmod 777 -R /mnt/disk3
mkdir /mnt/disk3/dn

sudo chmod 777 -R /mnt/disk4
mkdir /mnt/disk4/dn

mkdir /mnt/disk1/sparkTmp
mkdir /mnt/disk2/sparkTmp
mkdir /mnt/disk3/sparkTmp
mkdir /mnt/disk4/sparkTmp
vim spark-1.2.1-bin-hadoop2.4/conf/spark-env.sh

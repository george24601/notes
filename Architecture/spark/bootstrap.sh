#or use openjdk
sudo apt-get install openjdk-7-jdk

#open all tcp/udp ports
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

sudo chmod 777 -R /mnt/disk2

sudo chmod 777 -R /mnt/disk3

sudo chmod 777 -R /mnt/disk4

mkdir /mnt/disk1/sparkTmp
mkdir /mnt/disk2/sparkTmp
mkdir /mnt/disk3/sparkTmp
mkdir /mnt/disk4/sparkTmp

mkdir /mnt/disk1/dn
mkdir /mnt/disk2/dn
mkdir /mnt/disk3/dn
mkdir /mnt/disk4/dn

sudo apt-get update
#or use openjdk
sudo apt-get install openjdk-7-jdk

#install spark
tar -xvf spark-1.2.1-bin-hadoop2.4.tgz

#open all ports
sudo apt-get install ufw
sudo ufw enabled
sudo ufw allow 1:65535/tcp
sudo ufw allow 1:65535/udp

#spark master listening
sudo ufw allow 7077

#install hadoop
sudo apt-get install ssh
tar -xvf hadoop-2.6.0.tar.gz

#hadoop name node listening
sudo ufw allow 8020

#hadoop resource node listening
sudo ufw allow 8031

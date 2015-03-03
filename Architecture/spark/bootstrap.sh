sudo apt-get update
#or use openjdk
sudo apt-get install openjdk-7-jdk

#install spark
tar -xvf spark-1.2.1-bin-hadoop2.4.tgz

sudo apt-get install ufw
sudo ufw enabled
sudo ufw allow 10000:60000/TCP
sudo ufw allow 10000:60000/UDP

#spark master listening
sudo ufw allow 7077

#install hadoop
sudo apt-get install ssh
tar -xvf hadoop-2.6.0.tar.gz

#hadoop name node listening
sudo ufw allow 8020

#hadoop resource node listening
sudo ufw allow 8031

#install hadoop-env.sh

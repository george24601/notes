sudo -i

cd /home/hdp/hadoop-2.7.1

sudo sbin/hadoop-daemon.sh start namenode
sudo sbin/yarn-daemon.sh start resourcemanager

#####

sudo -i

cd /home/hdp/hadoop-2.7.1

sudo sbin/hadoop-daemon.sh start datanode
sudo sbin/yarn-daemon.sh start nodemanager

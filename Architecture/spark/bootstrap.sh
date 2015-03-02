#install java
JDK_NAME=jdk1.8.0_31

tar -xvf jdk-8u31-linux-x64.gz
sudo mkdir -p /usr/lib/jvm
sudo mv ./$JDK_NAME/usr/lib/jvm/

sudo update-alternatives --install "/usr/bin/java" "java" "/usr/lib/jvm/jdk1.8.0_31/bin/java" 1
sudo update-alternatives --install "/usr/bin/javac" "javac" "/usr/lib/jvm/jdk1.8.0_31/bin/javac" 1
sudo update-alternatives --install "/usr/bin/javaws" "javaws" "/usr/lib/jvm/jdk1.8.0_31/bin/javaws" 1

sudo chmod a+x /usr/bin/java
sudo chmod a+x /usr/bin/javac
sudo chmod a+x /usr/bin/javaws
sudo chown -R root:root /usr/lib/jvm/jdk1.8.0_31

#install spark
tar -xvf spark-1.2.1-bin-hadoop2.4.tgz

#install hadoop
tar -xvf hadoop-2.6.0.tar.gz

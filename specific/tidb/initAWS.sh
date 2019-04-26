#check RHEL version
cat /etc/redhat-release
#install for RHEL 7
sudo rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

yum -y install python-pip

#prepare for ansible
pip install Jinja2==2.7.2 MarkupSafe==0.11
#install ansible

yum install epel-release

yum install ansible

<<NEEDPORT
2379,2380,20160,4000

NEEDPORT

ansible-playbook local_prepare.yml

ansible-playbook -vvv bootstrap.yml -K --private-key="tidbkey.pem" --key-file="tidbkey.pem" -K > bs.txt

ansible-playbook deploy.yml --private-key="tidbkey.pem" --key-file="tidbkey.pem" > dep.txt

ansible-playbook -vvv start.yml  --private-key="tidbkey.pem" --key-file="tidbkey.pem" > start.txt

ansible-playbook -vvv stop.yml  --private-key="tidbkey.pem" --key-file="tidbkey.pem" > stop.txt

#on each machine
#install ntp
yum install ntp ntpdate ntp-doc

#turn on service
chkconfig ntpd on

#sync the system clock
ntpdate pool.ntp.org

#Start the NTP server
/etc/init.d/ntpd start

#mount instance storage
df -h
lsblk
mkfs -t ext4 /dev/nvme0n1
mkdir instanceStorage
mount /dev/nvme0n1 /home/ec2-user/instanceStorage 

#make sure you edit /etc/fstab
#/dev/nvme0n1 /home/ec2-user/instanceStorage                      ext4     defaults        1 1

#test instance storage speed
dd bs=4k count=25000 oflag=direct if=/dev/zero of=/home/ec2-user/instanceStorage/io_test.txt

#start ntp on centos/RHEL before proceed
sudo su
systemctl start ntpd
systemctl status ntpd

sudo chown ec2-user:ec2-user instanceStorage

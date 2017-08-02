#check RHEL version
cat /etc/redhat-release
#install for RHEL 7
sudo rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

yum -y install python-pip

#prepare for ansible
pip install Jinja2==2.7.2 MarkupSafe==0.11

#install ntp
yum install ntp ntpdate ntp-doc

#turn on service
chkconfig ntpd on

#sync the system clock
ntpdate pool.ntp.org

#Start the NTP server
/etc/init.d/ntpd start

#install ansible
yum install epel-release

yum install ansible

<<NEEDPORT
2379,2380,20160,4000

NEEDPORT

ansible-playbook bootstrap.yml -K --private-key="tidbkey.pem" --key-file="tidbkey.pem" -K

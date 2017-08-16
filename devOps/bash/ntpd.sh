#config
less /etc/ntp.conf

#check if server is accessible
ntpdate -q server_address

ntpdate 0.rhel.pool.ntp.org 1.rhel.pool.ntp.org

#restart the NTP daemon
service ntpd restart

#Make sure that ntpd is started at boot time:
chkconfig ntpdate on


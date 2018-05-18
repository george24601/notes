#installation will have its stuff in /usr/lib/systemd/system/td-agent

#If you want to customize systemd behaviour, put your td-agent.service into /etc/systemd/system

#The /etc/init.d/td-agent script is provided to start, stop, or restart the agent.

curl -L https://toolbelt.treasuredata.com/sh/install-amazon1-td-agent3.sh | sh

sudo vi /etc/td-agent/td-agent.conf
#make sure we run this first!!!
sudo /usr/sbin/td-agent-gem install fluent-plugin-elasticsearch
sudo /usr/sbin/td-agent-gem install fluent-plugin-concat


#make sure fluentd has access to weblogs
sudo chmod og+rx /var/log/httpd
sudo chmod og+r /var/log/messages /var/log/secure /var/log/httpd/*


######
#You can check your configuration without plugins start
fluentd --dry-run -c fluent.conf

docker run -it -p 24224:24224 --network host -v /home/ec2-user/test.conf:/fluentd/etc/test.conf -e FLUENTD_CONF=test.conf fluent/fluentd:latest

docker run -itd -p 24224:24224 --network host -v /home/ec2-user/test.conf:/fluentd/etc/test.conf -e FLUENTD_CONF=test.conf fluent/fluentd:latest

sudo vim /etc/td-agent/td-agent.conf
sudo /etc/init.d/td-agent restart
sudo tail -f /var/log/td-agent/td-agent.log

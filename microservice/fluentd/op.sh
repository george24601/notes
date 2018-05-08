#installation will have its stuff in /usr/lib/systemd/system/td-agent

#If you want to customize systemd behaviour, put your td-agent.service into /etc/systemd/system

#The /etc/init.d/td-agent script is provided to start, stop, or restart the agent.

curl -L https://toolbelt.treasuredata.com/sh/install-amazon1-td-agent3.sh | sh

sudo vi /etc/td-agent/td-agent.conf
#make sure we run this first!!!
sudo /usr/sbin/td-agent-gem install fluent-plugin-elasticsearch

#make sure fluentd has access to weblogs
sudo chmod og+rx /var/log/httpd
sudo chmod og+r /var/log/messages /var/log/secure /var/log/httpd/*


######
#You can check your configuration without plugins start
fluentd --dry-run -c fluent.conf

#init.d start
sudo /etc/init.d/td-agent start

docker run -it -p 24224:24224 --network host -v /home/ec2-user/test.conf:/fluentd/etc/test.conf -e FLUENTD_CONF=test.conf fluent/fluentd:latest

docker run -itd -p 24224:24224 --network host -v /home/ec2-user/test.conf:/fluentd/etc/test.conf -e FLUENTD_CONF=test.conf fluent/fluentd:latest

aws ecs describe-container-instances --cluster dev_v2 --container-instances 938abc34-b3d6-46e7-bfe6-6a60e49764e1

aws ecs describe-container-instances --cluster dev_v2 --container-instances f68754f7-19b8-48b6-8cab-d92df3457aa7


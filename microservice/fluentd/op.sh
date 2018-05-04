#installation will have its stuff in /usr/lib/systemd/system/td-agent

#If you want to customize systemd behaviour, put your td-agent.service into /etc/systemd/system

#The /etc/init.d/td-agent script is provided to start, stop, or restart the agent.

curl -L https://toolbelt.treasuredata.com/sh/install-redhat-td-agent3.sh | sh

# Amazon Linux 1
curl -L https://toolbelt.treasuredata.com/sh/install-amazon1-td-agent3.sh | sh
# Amazon Linux 2
curl -L https://toolbelt.treasuredata.com/sh/install-amazon2-td-agent3.sh | sh

sudo vi /etc/td-agent/td-agent.conf

#You can check your configuration without plugins start
fluentd --dry-run -c fluent.conf

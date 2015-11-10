#stop the agent, can replace stop with start or restart
sudo /etc/init.d/datadog-agent restart

#List every attributes available that has a type supported by JMXFetch
sudo /etc/init.d/datadog-agent jmx list_everything

sudo /etc/init.d/datadog-agent jmx list_matching_attributes
sudo /etc/init.d/datadog-agent jmx list_not_matching_attributes

#can also check with status or info
sudo /etc/init.d/datadog-agent info

#where yaml is stored
/etc/dd-agent/conf.d/


#log location
tail /var/log/supervisor/datadog-supervisord.log
tail /var/log/datadog/collector.log
tail /var/log/datadog/dogstatsd.log
tail /var/log/datadog/forwarder.log

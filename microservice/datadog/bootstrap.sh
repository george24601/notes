#use systemd/init.d as lifecycle management
#If you ever want to stop the Agent, run:

    sudo stop datadog-agent

#And to run it again run:

    sudo start datadog-agent

echo -n "custom_metric:60|g|#shell" >/proc/net/udp/8125

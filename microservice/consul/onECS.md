You can easily do this by containerizing the Consul agent software and launching it via an EC2 UserData script that is invoked when the ECS instance is launched. The agent needs to communicate with a Consul server that stores the service directory.

While the documentation provided with the official image is fairly comprehensive, it is geared towards environments where setting the container networking to the host mode is possible, which at present is not supported by ECS.

When running the Consul container on the default bridge network, an additional configuration parameter is required to enable host-to-host gossip between Consul agents. The parameter in question is the advertise parameter. It is intended for scenarios where the routable IP to the agent is not discoverable and needs to be manually configured. In the case of the container, we need the IP of the ECS cluster host instead of the container IP on the hosts’ bridge network.

Deployment Plan
----------
1. ECS cluster with fixed min/max scaling factor

2. use docker command to try the command myself

3. once we settle on a proper command, add that to ECS task definition

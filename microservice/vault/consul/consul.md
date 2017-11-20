Every node that provides services to Consul runs a Consul agent. Running an agent is not required for discovering other services or getting/setting key/value data. The agent is responsible for health checking the services on the node as well as the node itself.

The agents talk to one or more Consul servers. The Consul servers are where data is stored and replicated. The servers themselves elect a leader.

Instead of only having server nodes, Consul clients run on every node in the cluster. These clients are part of a gossip pool which serves several functions, including distributed health checking. The gossip protocol implements an efficient failure detector that can scale to clusters of any size without concentrating the work on any select group of servers.

Instead of only having server nodes, Consul clients run on every node in the cluster. These clients are part of a gossip pool which serves several functions, including distributed health checking. The gossip protocol implements an efficient failure detector that can scale to clusters of any size without concentrating the work on any select group of servers.

The strongly consistent nature of Consul means it can be used as a locking service for leader elections and cluster coordination. Eureka does not provide similar guarantees, and typically requires running ZooKeeper for services that need to perform coordination or have stronger consistency needs.

A service definition is the most common way to register services, so we'll use that approach for this step.

Consul loads all configuration files in the configuration directory, so a common convention on Unix systems is to name the directory something like /etc/consul.d (the .d suffix implies "this directory contains a set of configuration files

Consul facilitates auto-join by enabling the auto-discovery of instances in AWS, Google Cloud or Azure with a given tag key/value. To use the integration, add the retry_join_ec2, retry_join_gce or the retry_join_azure nested object to your Consul configuration file.

We will use the check definition approach because, just like with services, definitions are the most common way to set up checks.

. Similarly, even if you need to rebuild a new Consul server to replace the failed node, you may wish to do that immediately. Keep in mind that the rebuilt server needs to have the same IP address as the failed server. Again, once this server is online and has rejoined, the cluster will return to a fully healthy state.

if building a new server with the same IP isn't an option, you need to remove the failed server. Usually, you can issue a consul force-leave command to remove the failed server if it's still a member of the cluster.

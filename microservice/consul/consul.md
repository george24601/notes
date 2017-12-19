Every node that provides services to Consul runs a Consul agent. Running an agent is not required for discovering other services or getting/setting key/value data. The agent is responsible for health checking the services on the node as well as the node itself.

Instead of only having server nodes, Consul clients run on every node in the cluster. These clients are part of a gossip pool which serves several functions, including distributed health checking. The gossip protocol implements an efficient failure detector that can scale to clusters of any size without concentrating the work on any select group of servers.

Consul loads all configuration files in the configuration directory, so a common convention on Unix systems is to name the directory something like /etc/consul.d (the .d suffix implies "this directory contains a set of configuration files

if building a new server with the same IP isn't an option, you need to remove the failed server. Usually, you can issue a consul force-leave command to remove the failed server if it's still a member of the cluster.

As a sanity check, the consul info command is a useful tool. It can be used to verify raft.num_peers is now 2, and you can view the latest log index under raft.last_log_index. When running consul info on the followers, you should see raft.last_log_index converge to the same value once the leader begins replication. That value represents the last log entry that has been stored on disk.

Each node in a cluster must have a unique name. By default, Consul uses the hostname of the machine

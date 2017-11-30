Each key can be entered via multiple mechanisms on multiple computers and it will work. This allows each shard of the master key to be on a distinct machine for better security.

unsealing it is a very manual process. We have plans in the future to make it easier. For the time being, the best method is to manually unseal multiple Vault servers in HA mode. Use a tool such as Consul to make sure you only query Vault servers that are unsealed.

Response Wrapping???

You can tell if a data store supports high availability mode ("HA") by starting the server and seeing if "(HA available)" is output next to the data store information.

Vault also supports split data/HA mode, whereby the lock value and the rest of the data live separately

. Rather than over the network, this communication takes place within Vault's encrypted storage; the active node writes this information and unsealed standby Vault nodes can read it.

For the request forwarding method, the servers need direct communication with each other.

High availability mode is automatically enabled when using a data store that supports it.

To be highly available, one of the Vault server nodes grabs a lock within the data store.

Certain storage backends can support high availability mode, which enable them to store both Vault's information in addition to the HA lock.

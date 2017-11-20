Storage Backend - A storage backend is responsible for durable storage of encrypted data. Backends are not trusted by Vault and are only expected to provide durability. The storage backend is configured when starting the Vault server.

All data that flows between Vault and the Storage Backend passes through the barrier. The barrier ensures that only encrypted data is written out, and that data is verified and decrypted on the way in. Much like a bank vault, the barrier must be "unsealed" before anything inside can be accessed.

Every request to Vault to Vault and response from Vault goes through the configured audit backends.

Vault takes an authenticated user and returns a client token that can be used for future requests. As an example, the userpass backend uses a username and password to authenticate the user. Alternatively, the github backend allows users to authenticate via GitHub.

Only the storage backend and the HTTP API are outside, all other components are inside the barrier.

. When the Vault is initialized it generates an encryption key which is used to protect all the data. That key is protected by a master key. By default, Vault uses a technique known as Shamir's secret sharing algorithm to split the master key into 5 shares, any 3 of which are required to reconstruct the master key.

Once unsealed, Vault loads all of the configured audit, credential and secret backends.

An authentication request flows through core and into a credential backend, which determines if the request is valid and returns a list of associated policies.

any downtime of the Vault service can affect downstream clients. Vault is designed to support a highly available deploy to ensure a machine or process failure is minimally disruptive.

Vault is typically bound by the IO limits of the storage backend rather than the compute requirements. T

Servers sharing a storage backend, only a single instance will be active at any time while all other instances are hot standbys.

only unsealed servers act as a standby

To view this data, you must send a signal to the Vault process: on Unix, this is USR1 while on Windows it is BREAK. Once Vault receives the signal, it will dump the current telemetry information to the agent's stderr.

The encryption key is also stored with the data, but encrypted with another encryption key known as the master key. The master key isn't stored anywhere.

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

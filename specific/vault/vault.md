All secrets in Vault have a lease associated with them. At the end of the lease, Vault will automatically revoke that secret. Clients are able to renew leases via built-in renew APIs.

The "dynamic secrets" feature of Vault is ideal for scripts: an AWS access key can be generated for the duration of a script, then revoked. The keypair will not exist before or after the script runs, and the creation of the keys are completely logged.
This is an improvement over using something like Amazon IAM but still effectively hardcoding limited-access access tokens in various places.

The Vault server is the only piece of the Vault architecture that interacts with the data storage and backends

Every request to Vault to Vault and response from Vault goes through the configured audit backends.

Vault takes an authenticated user and returns a client token that can be used for future requests. As an example, the userpass backend uses a username and password to authenticate the user. Alternatively, the github backend allows users to authenticate via GitHub.

Only the storage backend and the HTTP API are outside, all other components are inside the barrier.

Once unsealed, Vault loads all of the configured audit, credential and secret backends.

An authentication request flows through core and into a credential backend, which determines if the request is valid and returns a list of associated policies.

Servers sharing a storage backend, only a single instance will be active at any time while all other instances are hot standbys.

The encryption key is also stored with the data, but encrypted with another encryption key known as the master key. The master key isn't stored anywhere.

Each key can be entered via multiple mechanisms on multiple computers and it will work. This allows each shard of the master key to be on a distinct machine for better security.

completely automated Vault and Consul clusters (except for the Vault unseal step). The peers needs IPs but with proper "failure" (graceful leave vs. just shutdown) this becomes a non-issue?

Unsealing has been done manually by the security team who holds the tokens and the HA backend is S3

One approach is putting the key in a hard to guess location before the application starts and wipe the key once it was read to memory. The time in which the key is available is shortened. The attack time-frame is reduced, but still the key was there. Wiping the key works only for one application startup. Containers and microservices in the Cloud are known to be restarted once they crashed. A restart of the application is no longer possible as the key is gone.

Vault allows specifying the number of total key shares and the number of key shares required to unseal Vault during initialization. That setting cannot be changed once Vault is initialized

export VAULT_TOKEN for authenticated access

The trick there will be that both the
ELB and the Vault instances must be accessible, since the standby nodes do a 307 redirect
to the active instance.

unsealing it is a very manual process. We have plans in the future to make it easier. For the time being, the best method is to manually unseal multiple Vault servers in HA mode. Use a tool such as Consul to make sure you only query Vault servers that are unsealed.

You can tell if a data store supports high availability mode ("HA") by starting the server and seeing if "(HA available)" is output next to the data store information.

---------
When a secrets engine is disabled, all secrets are revoked and the corresponding Vault data and configuration is removed. Any requests to route data to the original path would result in an error, but another secrets engine could now be enabled at that path.

seems that dymanic secrets works mostly with AWS?

The root token is the initial access token to configure Vault. It has root privileges, so it can perform any operation within Vault.

Just like secrets engines, auth methods default to their TYPE as the PATH

Each auth method has different configuration options, so please see the documentation for the full details.

init is the only time unsealed keys should be close togethear, e.g., use PGP, keybase.io instead




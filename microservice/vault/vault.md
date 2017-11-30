Vault can generate secrets on-demand for some systems, such as AWS or SQL databases. For example, when an application needs to access an S3 bucket, it asks Vault for credentials, and Vault will generate an AWS keypair with valid permissions on demand. After creating these dynamic secrets, Vault will also automatically revoke them after the lease is up

Vault can encrypt and decrypt data without storing it. This allows security teams to define encryption parameters and developers to store encrypted data in a location such as SQL without having to design their own encryption methods.

All secrets in Vault have a lease associated with them. At the end of the lease, Vault will automatically revoke that secret. Clients are able to renew leases via built-in renew APIs.

The "dynamic secrets" feature of Vault is ideal for scripts: an AWS access key can be generated for the duration of a script, then revoked. The keypair will not exist before or after the script runs, and the creation of the keys are completely logged.

This is an improvement over using something like Amazon IAM but still effectively hardcoding limited-access access tokens in various places.


While Consul can be used to store secret information and gate access using ACLs, it is not designed for that purpose. As such, data is not encrypted in transit nor at rest, it does not have pluggable authentication mechanisms, and there is no per-request auditing mechanism.

The strength of Consul is that it is fault tolerant and highly scalable. By using Consul as a backend to Vault, you get the best of both. Consul is used for durable storage of encrypted data at rest and provides coordination so that Vault can be highly available and fault tolerant. Vault provides the higher level policy management, secret leasing, audit logging, and automatic revocation.

Vault forces a mandatory lease contract with clients. All secrets read from Vault have an associated lease which enables operations to audit key usage, perform key rolling, and ensure automatic revocation. Vault provides multiple revocation mechanisms to give operators a clear "break glass" procedure after a potential compromise.

The Vault server is the only piece of the Vault architecture that interacts with the data storage and backends

the aws backend generates AWS access keys dynamically, on demand.

Token authentication is enabled by default in Vault and cannot be disabled

Initialization outputs two incredibly important pieces of information: the unseal keys and the initial root token. This is the only time ever that all of this data is known by Vault, and also the only time that the unseal keys should ever be so close together.

The process of teaching Vault how to decrypt the data is known as unsealing the Vault.

Vault behaves a lot like a virtual filesystem. The read/write/delete operations are forwarded to the backend, and the backend can choose to react to these operations however it wishes. For example, the kv backend simply passes this through to the storage backend (after encrypting data first).

However, the aws backend (which you'll see soon), will read/write IAM policies and access tokens. So, while you might do a vault read aws/deploy, this isn't reading from the physical path aws/deploy. Instead, the AWS backend is dynamically generating an access key based on the deploy policy.

All data that flows between Vault and the Storage Backend passes through the barrier. The barrier ensures that only encrypted data is written out, and that data is verified and decrypted on the way in. Much like a bank vault, the barrier must be "unsealed" before anything inside can be accessed.

Every request to Vault to Vault and response from Vault goes through the configured audit backends.

Vault takes an authenticated user and returns a client token that can be used for future requests. As an example, the userpass backend uses a username and password to authenticate the user. Alternatively, the github backend allows users to authenticate via GitHub.

Only the storage backend and the HTTP API are outside, all other components are inside the barrier.

Once unsealed, Vault loads all of the configured audit, credential and secret backends.

An authentication request flows through core and into a credential backend, which determines if the request is valid and returns a list of associated policies.

Servers sharing a storage backend, only a single instance will be active at any time while all other instances are hot standbys.

The encryption key is also stored with the data, but encrypted with another encryption key known as the master key. The master key isn't stored anywhere.

Discussions online
------------
I'll just say that I've seen multiple setups of completely automated Vault and Consul clusters (except for the Vault unseal step), so it is possible! You're right that the peers needs IPs but with proper "failure" (graceful leave vs. just shutdown) this becomes a non-issue.

running a 3 node consul with vault running on the same nodes. Since only one can be master at a time, only one is actually live in the ELB.

Unsealing has been done manually by the security team who holds the tokens and the HA backend is S3

Vault would need 3 security guys on the line in case it goes down. Its running in HA - the likelihood of it losing all 3 unsealed nodes over the weekend or at night is fairly low IMO. If it can hobble along until a business day where we spin up more node(s) and have security unseal, I think we're good. Also, waking people up at their homes isnt the end of the world either.

One approach is putting the key in a hard to guess location before the application starts and wipe the key once it was read to memory. The time in which the key is available is shortened. The attack time-frame is reduced, but still the key was there. Wiping the key works only for one application startup. Containers and microservices in the Cloud are known to be restarted once they crashed. A restart of the application is no longer possible as the key is gone.

Vault never stores a key in a persistent location. Starting/restarting Vault always requires one or more operators to unseal Vault.

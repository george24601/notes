While Consul can be used to store secret information and gate access using ACLs, it is not designed for that purpose. As such, data is not encrypted in transit nor at rest, it does not have pluggable authentication mechanisms, and there is no per-request auditing mechanism.

The strength of Consul is that it is fault tolerant and highly scalable. By using Consul as a backend to Vault, you get the best of both. Consul is used for durable storage of encrypted data at rest and provides coordination so that Vault can be highly available and fault tolerant. Vault provides the higher level policy management, secret leasing, audit logging, and automatic revocation.

Vault and KMS differ in the scope of problems they are trying to solve. KMS is focused on securely storing encryption keys and supporting cryptographic operations (encrypt and decrypt) using those keys. It supports access controls and auditing as well.

The transit backend provides similar capabilities as KMS, allowing for encryption keys to be stored and cryptographic operations to be performed.

Vault forces a mandatory lease contract with clients. All secrets read from Vault have an associated lease which enables operations to audit key usage, perform key rolling, and ensure automatic revocation. Vault provides multiple revocation mechanisms to give operators a clear "break glass" procedure after a potential compromise.

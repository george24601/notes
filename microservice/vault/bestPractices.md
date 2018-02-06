Vault should always be used with TLS in production. If intermediate load balancers or reverse proxies are used to front Vault, they should not terminate TLS. This way traffic is always encrypted in transit to Vault and minimizes risks introduced by intermediate layer

running on bare metal should be preferred to a VM, and a VM preferred to a container. This reduces the surface area introduced by additional layers of abstraction and other tenants of the hardware. Both VM and container based deployments work, but should be avoided when possible to minimize risk.

When running a Vault as a single tenant application, users should never access the machine directly. Instead, they should access Vault through its API over the network. Use a centralized logging and telemetry solution for debugging. Be sure to restrict access to logs as need to know.

Risk of exposure should be minimized by disabling swap to prevent the operating system from paging sensitive data to disk. Vault attempts to "memory lock" to physical memory automatically, but disabling swap adds another layer of defense.

Vault is designed to run as an unprivileged user, and there is no reason to run Vault with root or Administrator privileges, which can expose the Vault process memory and allow access to Vault encryption keys. Running Vault as a regular user reduces its privilege. Configuration files for Vault should have permissions set to restrict access to only the Vault user.

A user or administrator that can force a core dump and has access to the resulting file can potentially access Vault encryption keys. Preventing core dumps is a platform-specific process; on Linux setting the resource limit RLIMIT_CORE to 0 disables core dumps. This can be performed by process managers and is also exposed by various shells; in Bash ulimit -c 0 will accomplish this.

Once setup, the root token should be revoked to eliminate the risk of exposure. Root tokens can be generated when needed, and should be revoked as soon as possible.

Audit logs securely hash any sensitive data, but access should still be restricted to prevent any unintended disclosures.

In practice, operators should not use the token create command to generate Vault tokens for users or machines. Instead, those users or machines should authenticate to Vault using any of Vault's configured auth methods such as GitHub, LDAP, AppRole, etc.

Vault should always point to a local Consul agent that is on the same node as itself.

Setting advertise_addr in the Vault configuration should fix your problem;

However, because it authenticates more generalized IAM principals, this method doesn't offer more granular controls beyond binding to a given IAM principal without the use of inferencing.



Every token has an ID, name, type, and rule set. The ID is a randomly generated UUID, making it infeasible to guess. The name is opaque to Consul and human readable. The type is either "client" (meaning the token cannot modify ACL rules) or "management" (meaning the token is allowed to perform all actions).

The token ID is passed along with each RPC request to the servers. Consul's HTTP endpoints can accept tokens via the token query string parameter, or the X-Consul-Token request header.

By default, Consul will allow all actions.

Since Consul snapshots actually contain ACL tokens, the Snapshot API requires a management token for snapshot operations and does not use a special policy.

All nodes (clients and servers) must be configured with an acl_datacenter which enables ACL enforcement but also specifies the authoritative datacenter. Consul relies on RPC forwarding to support multi-datacenter configurations.

To avoid consistency issues, a single datacenter is considered authoritative and stores the canonical set of tokens.

When a request is made to an agent in a non-authoritative datacenter, it must be resolved into the appropriate policy. This is done by reading the token from the authoritative server and caching the result for a configurable acl_ttl. The implication of caching is that the cache TTL is an upper bound on the staleness of policy that is enforced. I

or the cache may be extended if the acl_down_policy is set accordingly.

Double check the ACL bootstrap guides!

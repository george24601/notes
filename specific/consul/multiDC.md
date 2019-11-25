In general, data is not replicated between different Consul datacenters. When a request is made for a resource in another datacenter, the local Consul servers forward an RPC request to the remote Consul servers for that resource and return the results. If the remote datacenter is not available, then those resources will also not be available, but that won't otherwise affect the local datacenter.

datacenter names are opaque to Consul; they are simply labels that help human operators reason about the Consul clusters.

If service discovery is to be used across datacenters, the network must be able to route traffic between IP addresses across regions as well. Usually, this means that all datacenters must be connected using a VPN or other tunneling mechanism. Consul does not handle VPN or NAT traversal for you.

When a server receives a request for a different datacenter, it forwards it to a random server in the correct datacenter. That server may then forward to the local leader

This results in a very low coupling between datacenters, but because of failure detection, connection caching and multiplexing, cross-datacenter requests are relatively fast and reliable.

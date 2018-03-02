instead of making HTTP API requests to Consul, a host can use the DNS server directly via name lookups like redis.service.us-east-1.consul. This query automatically translates to a lookup of nodes that provide the redis service, are located in the us-east-1 datacenter, and have no failing health checks. It's that simple!

specifically client_addr, ports.dns, recursors, domain, and dns_config. By default, Consul will listen on 127.0.0.1:8600 for DNS queries in the consul. domain, without support for further DNS recursion.

By default, Consul will listen on 127.0.0.1:8600 for DNS queries in the consul. domain, without support for further DNS recursion

One option is to use a custom DNS resolver library and point it at Consul. 
Another option is to set Consul as the DNS server for a node and provide a recursors configuration so that non-Consul queries can also be resolved. 
The last method is to forward all queries for the "consul." domain to a Consul agent from the existing DNS server.

In DNS, all queries are case-insensitive

The format of a standard service lookup is:
```
[tag.]<service>.service[.datacenter].<domain>
```

by default, Consul does not resolve DNS records outside the .consul. zone unless the recursors configuration option has been set. As an example of how this changes Consul's behavior, suppose a Consul DNS reply includes a CNAME record pointing outside the .consul TLD. The DNS reply will only include CNAME records by default. By contrast, when recursors is set and the upstream resolver is functioning correctly, Consul will try to resolve CNAMEs and include any records (e.g. A, AAAA, PTR) for them in its DNS reply.


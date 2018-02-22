By default, Consul will listen on 127.0.0.1:8600 for DNS queries in the consul. domain, without support for further DNS recursion

One option is to use a custom DNS resolver library and point it at Consul. Another option is to set Consul as the DNS server for a node and provide a recursors configuration so that non-Consul queries can also be resolved. The last method is to forward all queries for the "consul." domain to a Consul agent from the existing DNS server.

A node lookup, a simple query for the address of a named node, looks like this
```
<node>.node[.datacenter].<domain>
```

The format of a standard service lookup is
```
[tag.]<service>.service[.datacenter].<domain>
```

by default, Consul does not resolve DNS records outside the .consul. zone unless the recursors configuration option has been set. As an example of how this changes Consul's behavior, suppose a Consul DNS reply includes a CNAME record pointing outside the .consul TLD. The DNS reply will only include CNAME records by default. By contrast, when recursors is set and the upstream resolver is functioning correctly, Consul will try to resolve CNAMEs and include any records (e.g. A, AAAA, PTR) for them in its DNS reply.

/etc/dnsmasq.d



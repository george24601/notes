Canonical Name record
------
CNAME record is a resource record in the Domain Name System (DNS) used to specify that a domain name is an alias for another domain (the 'canonical' domain).

This can prove convenient when running multiple services (like an FTP server and a webserver; each running on different ports) from a single IP address. One can, for example, point ftp.example.com and www.example.com to the DNS entry for example.com, which in turn has an A record which points to the IP address. Then, if the IP address ever changes, one only has to record the change in one place within the network: in the DNS A record for example.com.

CNAME records must always point to another domain name, never directly to an IP address.

The DNS root is unnamed, expressed as the empty label terminated by the dot.

127.0.0.1 is the loopback address (also known as localhost)
0.0.0.0 is a non-routable meta-address used to designate an invalid, unknown, or non-applicable target (a ‘no particular address’ place holder)
In the context of a route entry, it usually means the default route.
In the context of servers, 0.0.0.0 means all IPv4 addresses on the local machine. If a host has two IP addresses, 192.168.1.1 and 10.1.2.1, and a server running on the host listens on 0.0.0.0, it will be reachable at both of those IPs.

The class A network number 127 is assigned the loopback function, that is, a datagram sent by a higher level protocol to a network 127 address should loop back inside the host. No datagram sent to a network 127 address should ever appear on any network anywhere.


EIP
---------
a static IPv4 address designed for dynamic cloud computing

all AWS accounts are limited to 5 Elastic IP addresses per region

Instances in the public subnet with Elastic IPv4 addresses (example: 198.51.100.1), which are public IPv4 addresses that enable them to be reached from the Internet. The instances can have public IP addresses assigned at launch instead of Elastic IP addresses.

authoritative name server
--------
 name server that has definitive information about one part of the Domain Name System (DNS) and that responds to requests from a DNS resolver by returning the applicable information,e.g., return the the list of all name servers within the request subdomain
Amazon Route 53 name servers are the authoritative name servers for every domain that uses Amazon Route 53 as the DNS service.

DNS resolver
--------
A DNS server, often managed by an internet service provider (ISP), that acts as an intermediary between user requests and DNS name servers

Hosted zone
--------
A container for resource record sets, which include information about how you want to route traffic for a domain (such as example.com) and all of its subdomains.. A hosted zone has the same name as the corresponding domain.

Any limite on the # of connections a brower that can connect tot he host?

Why DNS uses UDP? for de-alias speed, and less than 512 bytes. However, the replication between master and region replica is done by TCP





SRV record
----------
_service._proto.name. TTL class SRV priority weight port target.
e.g.,
```
_sip._tcp.example.com. 86400 IN SRV 0 5 5060 sipserver.example.com.
```

the target in SRV records must point to hostname with an address record (A or AAAA record). Pointing to a hostname with a CNAME record is not a valid configuration.



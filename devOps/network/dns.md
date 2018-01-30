EIP
---------
a static IPv4 address designed for dynamic cloud computing

all AWS accounts are limited to 5 Elastic IP addresses per region

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

SRV record
----------
_service._proto.name. TTL class SRV priority weight port target.
e.g.,
```
_sip._tcp.example.com. 86400 IN SRV 0 5 5060 sipserver.example.com.
```

the target in SRV records must point to hostname with an address record (A or AAAA record). Pointing to a hostname with a CNAME record is not a valid configuration.

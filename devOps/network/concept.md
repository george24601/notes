Subnet
--------
Computers that belong to a subnet are addressed with a common, identical, most-significant bit-group in their IP address.
 This results in the logical division of an IP address into two fields, a network or routing prefix and the "rest" field or host identifier. The rest field is an identifier for a specific host or network interface.

Traffic is exchanged (routed) between subnetworks with special gateways (routers) when the routing prefixes of the source address and the destination address differ. A router constitutes the logical or physical boundary between the subnets, e.g., inside a VPC, subsets are further division of VPC's CIDR block, and are non-intersecting between AZs, continous within a single AZ

Each subnet is served by a designated default router, but may consist internally of multiple physical Ethernet segments interconnected by network switches or network bridges.


Routing Table
--------
a data table stored in a router or a networked computer that lists the routes to particular network destinations

. Most nodes do not try to figure out which route(s) might work; instead, a node will send an IP packet to a gateway in the LAN, which then decides how to route the "package" of data to the correct destination. Each gateway will need to keep track of which way to deliver various packages of data, and for this it uses a Routing Table. A routing table is a database which keeps track of paths, like a map, and allows the gateway to provide this information to the node requesting the information.

With hop-by-hop routing, each routing table lists, for all reachable destinations, the address of the next device along the path to that destination: the next hop.

VPC
------------
The isolation between one VPC user and all other users of the same cloud (other VPC users as well as other public cloud users) is achieved normally through allocation of a private IP subnet and a virtual communication construct (such as a VLAN or a set of encrypted communication channels) per user. In a VPC, the previously described mechanism, providing isolation within the cloud, is accompanied with a VPN function (again, allocated per VPC user) that secures, by means of authentication and encryption, the remote access of the organization to its VPC cloud resources.
On AWS, when you create a VPC, it spans all AZs in the region, After creating a VPC, you can add one or more subnets in each Availability Zone. When you create a subnet, you specify the CIDR block for the subnet, which is a subset of the VPC CIDR block. Each subnet must reside entirely within one Availability Zone and cannot span zones


VPN
---------
extends a private network across a public network, and enables users to send and receive data across shared or public networks as if their computing devices were directly connected to the private network.

It is common for packets originating in private address spaces to be misrouted onto the Internet. Private networks often do not properly configure DNS services for addresses used internally and attempt reverse DNS lookups for these addresses, causing extra traffic to the Internet root nameservers. 

NAT
-----------
 remapping one IP address space into another by modifying network address information in Internet Protocol (IP) datagram packet headers while they are in transit across a traffic routing device

ll IP packets have a source IP address and a destination IP address. Typically packets passing from the private network to the public network will have their source address modified while packets passing from the public network back to the private network will have their destination address modified.

An implementation that only tracks ports can be quickly depleted by internal applications that use multiple simultaneous connections (such as an HTTP request for a web page with many embedded objects). This problem can be mitigated by tracking the destination IP address in addition to the port (thus sharing a single local port with many remote hosts), at the expense of implementation complexity and CPU/memory resources of the translation device.

Because the internal addresses are all disguised behind one publicly accessible address, it is impossible for external hosts to initiate a connection to a particular internal host without special configuration on the firewall to forward connections to a particular port. Applications such as VOIP, videoconferencing, and other peer-to-peer applications must use NAT traversal techniques to function.

This leaves the internal network ill-suited for hosting servers, as the NAT device has no automatic method of determining the internal host for which incoming packets are destined. This is not a problem for general web access and email. However, applications such as peer-to-peer file sharing, VoIP services, and video game consoles require clients to be servers as well. Incoming requests cannot be easily correlated to the proper internal host. Furthermore, many of these types of services carry IP address and port number information in the application data, potentially requiring substitution with deep packet inspection.

Canonical Name record
------
CNAME record is a resource record in the Domain Name System (DNS) used to specify that a domain name is an alias for another domain (the 'canonical' domain).

This can prove convenient when running multiple services (like an FTP server and a webserver; each running on different ports) from a single IP address. One can, for example, point ftp.example.com and www.example.com to the DNS entry for example.com, which in turn has an A record which points to the IP address. Then, if the IP address ever changes, one only has to record the change in one place within the network: in the DNS A record for example.com.

CNAME records must always point to another domain name, never directly to an IP address.

Local port forwarding
--------
 forward data securely from another client application running on the same computer as the Secure Shell Client. Local Port Forwarding lets a user connect from the local computer to another server. By using local port forwarding, firewalls that block certain web pages are able to be bypassed.

Two important items in local port forwarding are the destination server, and two port numbers. Connections from the SSH client are forwarded via the SSH server, then to a destination server. As stated above, local port forwarding forwards data from another client application running on the same computer as the Secure Shell Client. The Secure Shell client is configured to redirect data from a specified local port through the secure tunnel to a specified destination host and port. 

Some uses of local port forwarding:
Using local port forwarding to Receive Mail
Connect from a laptop to a website using an SSH tunnel.


---------
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

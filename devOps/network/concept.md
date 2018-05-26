Subnet
--------
Traffic is exchanged (routed) between subnetworks with special gateways (routers) when the routing prefixes of the source address and the destination address differ. A router constitutes the logical or physical boundary between the subnets, e.g., inside a VPC, subsets are further division of VPC's CIDR block, and are non-intersecting between AZs, continous within a single AZ

Each subnet is served by a designated default router, but may consist internally of multiple physical Ethernet segments interconnected by network switches or network bridges.

The instances in the public subnet can send outbound traffic directly to the Internet, whereas the instances in the private subnet can't. Instead, the instances in the private subnet can access the Internet by using a network address translation (NAT) gateway that resides in the public subnet. The database servers can connect to the Internet for software updates using the NAT gateway

A public subnet is a subnet that's associated with a route table that has a route to an Internet gateway.By contrast, a private subnet is a subnet without such a route. Usually, the default route for a private subnet points to a NAT device, though it could point to a hardware VPN or Direct Connect connection.



Routing Table
--------
a data table stored in a router or a networked computer that lists the routes to particular network destinations

. Most nodes do not try to figure out which route(s) might work; instead, a node will send an IP packet to a gateway in the LAN, which then decides how to route the "package" of data to the correct destination. Each gateway will need to keep track of which way to deliver various packages of data, and for this it uses a Routing Table. 

With hop-by-hop routing, each routing table lists, for all reachable destinations, the address of the next device along the path to that destination: the next hop.

VPN
---------
It is common for packets originating in private address spaces to be misrouted onto the Internet. Private networks often do not properly configure DNS services for addresses used internally and attempt reverse DNS lookups for these addresses, causing extra traffic to the Internet root nameservers. 

NAT
-----------
 remapping one IP address space into another by modifying network address information in Internet Protocol (IP) datagram packet headers while they are in transit across a traffic routing device

An implementation that only tracks ports can be quickly depleted by internal applications that use multiple simultaneous connections (such as an HTTP request for a web page with many embedded objects). This problem can be mitigated by tracking the destination IP address in addition to the port (thus sharing a single local port with many remote hosts), at the expense of implementation complexity and CPU/memory resources of the translation device.

Because the internal addresses are all disguised behind one publicly accessible address, it is impossible for external hosts to initiate a connection to a particular internal host without special configuration on the firewall to forward connections to a particular port. Applications such as VOIP, videoconferencing, and other peer-to-peer applications must use NAT traversal techniques to function.

This leaves the internal network ill-suited for hosting servers, as the NAT device has no automatic method of determining the internal host for which incoming packets are destined. This is not a problem for general web access and email. However, applications such as peer-to-peer file sharing, VoIP services, and video game consoles require clients to be servers as well. Incoming requests cannot be easily correlated to the proper internal host. Furthermore, many of these types of services carry IP address and port number information in the application data, potentially requiring substitution with deep packet inspection.

Internet gateway
----------
to provide a target in your VPC route tables for Internet-routable traffic, and to perform network address translation (NAT) for instances that have been assigned public IPv4 addresses.
To enable access to or from the Internet for instances in a VPC subnet, you must do the following:

Attach an Internet gateway to your VPC.

Ensure that your subnet's route table points to the Internet gateway.

Ensure that instances in your subnet have a globally unique IP address (public IPv4 address, Elastic IP address, or IPv6 address).

Ensure that your network access control and security group rules allow the relevant traffic to flow to and from your instance.

Your instance is only aware of the private (internal) IP address space defined within the VPC and subnet.


LB
-------
1. can use dns to do LB -> but client side cache will still return the deleted ip

2. A single request might come as multiple packets, need it to be stickly, i..e, we need to maintian the mapping! - 4 layer load balancing

3. 7 layer-loadblaancing, change packet all the way to the http level - NAT mode

4. Separate request and responding, the server behind respond directly => all servers will have the same VIP bound to their loopback -> use ARP to broacast VIP, and machine with such IP will reply its own MAC address, but only LB can respond to the ARP reqeust -> but LB will not change IP data header, that means server ports must match LB prots - DR mode

5. actual LB instances need to have same VIP and (virtual) MAC address  via ARP request



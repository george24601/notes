Subnet
--------
Each subnet is served by a designated default router, but may consist internally of multiple physical Ethernet segments interconnected by network switches or network bridges.

A public subnet is a subnet that's associated with a route table that has a route to an Internet gateway.By contrast, a private subnet is a subnet without such a route. Usually, the default route for a private subnet points to a NAT device, though it could point to a hardware VPN or Direct Connect connection.

Routing Table
--------
a data table stored in a router or a networked computer that lists the routes to particular network destinations

. Most nodes do not try to figure out which route(s) might work; instead, a node will send an IP packet to a gateway in the LAN, which then decides how to route the "package" of data to the correct destination. Each gateway will need to keep track of which way to deliver various packages of data, and for this it uses a Routing Table. 

With hop-by-hop routing, each routing table lists, for all reachable destinations, the address of the next device along the path to that destination: the next hop.

NAT
-----------
 remapping one IP address space into another by modifying network address information in Internet Protocol (IP) datagram packet headers while they are in transit across a traffic routing device

For one-to-many NAT, a VIP address is advertised from the NAT device (often a router), and incoming data packets destined to that VIP address are routed to different actual IP addresses (with address translation).

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


### LB
1. can use dns to do LB -> but client side cache will still return the deleted ip
2. A single request might come as multiple packets, need it to be stickly, i..e, we need to maintian the mapping! - 4 layer load balancing
3. 7 layer-loadblaancing, change packet all the way to the http level - NAT mode
4. Separate request and responding, the server behind respond directly => all servers will have the same VIP bound to their loopback -> use ARP to broacast VIP, and machine with such IP will reply its own MAC address, but only LB can respond to the ARP reqeust -> but LB will not change IP data header, that means server ports must match LB prots - DR mode
5. actual LB instances need to have same VIP and (virtual) MAC address  via ARP request

### keepalived

* Nginx clusters, with each instance deploys keepalived, and set them with the same virtual IP. But only one instance is up (active-standby)
* use lvs/f5 IN FRONT OF nginx, e.g. f5 can do 100k qps, and use the same keepalived + virtual IP trick on lvs - enough for most cases
* If you need EVEN HIGHER, add mutilple IPs for the same domain name,i.e., DNS polling

Different between implementation of session and cookie?

Use script to calculate current tcp connections, and group them by the state

# MAC address

a unique identifier assigned to a network interface controller (NIC) for communications at the data link layer of a network segment.

A network node may have multiple NICs and each NIC must have a unique MAC address. Sophisticated network equipment such as a multilayer switch or router may require one or more permanently assigned MAC addresses.

he MAC address is expected to uniquely identify each node on that segment and allows frames to be marked for specific hosts. It thus forms the basis of most of the link layer (OSI Layer 2) networking upon which upper layer protocols rely to produce complex, functioning networks.

Although intended to be a permanent and globally unique identification, it is possible to change the MAC address on most modern hardware. Changing MAC addresses is necessary in network virtualization. It can also be used in the process of exploiting security vulnerabilities. This is called MAC spoofing.

#HTTP 2.0

#Routing

$ ip route list table all
default via 192.168.1.1 dev wlp3s0  proto static  metric 600 
169.254.0.0/16 dev docker0  scope link  metric 1000 linkdown 
172.17.0.0/16 dev docker0  proto kernel  scope link  src 172.17.0.1 linkdown 
192.168.1.0/24 dev wlp3s0  proto kernel  scope link  src 192.168.1.170  metric 600 
broadcast 127.0.0.0 dev lo  table local  proto kernel  scope link  src 127.0.0.1 
local 127.0.0.0/8 dev lo  table local  proto kernel  scope host  src 127.0.0.1


So 192.168.1.0/24 dev wlp3s0 means “send packets in the 192.168.1.0/24 range to the wlp3s0 network device. That’s not so complicated!

It turns out that forcing packets destined for 169.254.169.254 to go somewhere else is totally possible! Here’s the iptables rule that they suggest using:

```
iptables \
  --append PREROUTING \
  --protocol tcp \
  --destination 169.254.169.254 \
  --dport 80 \
  --in-interface docker0 \
  --jump DNAT \
  --table nat \
  --to-destination $YOUR_IP_ADDRESS:8181
```

it only applies to tcp packets to 169.254.169.254 port 80 that came from the docker0 interface (--protocol tcp, --dport 80, --destination 169.254.168.254, --in-interface docker0)

it happens at the PREROUTING stage (before the packet gets assigned a network interface)
it (--jump DNAT, --table nat, --to-destination $YOUR_IP_ADDRESS:8181)

Source NAT is like destination NAT, except instead of rewriting destination IP address, it rewrites source IP addresses!

The place I’ve used source NAT before is also for container stuff – if you have a bunch of containers with weird virtual container IP addresses sending packets to the outside world, you can’t just let them use those IP addresses!! The outside world (like google) has no idea about your container IPs and will not be able to reply to those packets. So you need to pretend that they come from your host.

If this is you, you probably want an iptables rule something like this on your host:

```
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
```

C10K - PID was a signed 16-bit int - i.e. 32k processes max

how to handle corss domain problem?
resend vs redirect?
full conneciton q vs half connection q

### Push CDNs vs Pull CDNs

Ensure that your VPCs do not have overlapping IPv4 CIDR blocks. If they do, the status of the VPC peering connection immediately goes to failed

You have a limit on the number of active and pending VPC peering connections that you can have per VPC.

If the IPv4 CIDR block of a VPC in a VPC peering connection falls outside of the private IPv4 address ranges specified by RFC 1918, private DNS hostnames for that VPC cannot be resolved to private IP addresses. To resolve private DNS hostnames to private IP addresses, you can enable DNS resolution support for the VPC peering connection. For more information, see Enabling DNS Resolution Support for a VPC Peering Connection.

You must both create and accept the VPC peering connection request yourself to activate it.

Select the VPC peering connection that you've created, and choose Actions, Accept Request.

To send private IPv4 traffic from your instance to an instance in a peer VPC, you must add a route to the route table that's associated with your subnet in which your instance resides. The route points to the CIDR block (or portion of the CIDR block) of the peer VPC in the VPC peering connection.

If a subnet is not explicitly associated with a route table, it uses the main route table by default.

You have a limit on the number of entries you can add per route table. If the number of VPC peering connections in your VPC exceeds the route table entry limit for a single route table, consider using multiple subnets that are each associated with a custom route table.

The owner of the other VPC in the peering connection must also add a route to their subnet's route table to direct traffic back to your VPC.

add add a CNAME to the dev VPC to resolve to the tidb's internal ELB


A customer gateway is the anchor on your side of that connection. It can be a physical or software appliance. The anchor on the AWS side of the VPN connection is called a virtual private gateway.

the VPN connection consists of two tunnels to provide increased availability for the Amazon VPC service. If there's a device failure within AWS, your VPN connection automatically fails over to the second tunnel so that your access isn't interrupted.

When you configure your customer gateway, it's therefore important that you configure both tunnels.

You can create additional VPN connections to other VPCs using the same customer gateway device. You can reuse the same customer gateway IP address for each of those VPN connections.

The virtual private gateway is not the initiator; your customer gateway must initiate the tunnels.

To protect against a loss of connectivity if your customer gateway becomes unavailable, you can set up a second VPN connection.

This team (which may or may not consist of you) must use the AWS Management Console to create a VPN connection and get the information that you need to configure your customer gateway.

To create a VPN connection in AWS, you need the following information.

	1. Customer gateway vendor (for example, Cisco), platform (for example, ISR Series Routers), and software version (for example, IOS 12.4)

	2. The internet-routable IP address for the customer gateway device's external interface.

	3. (Optional) Border Gateway Protocol (BGP) Autonomous System Number (ASN) of the customer gateway.

	4. (Optional) The ASN for the Amazon side of the BGP session.

        5. Tunnel information for each VPN tunnel	

The configuration file for your customer gateway includes the values that you specify for the above items. It also contains any additional values required for setting up the VPN tunnels, including the outside IP address for the virtual private gateway. This value is static unless you recreate the VPN connection in AWS.

Configuring a Firewall Between the Internet and Your Customer Gateway?

Setting Up an AWS VPN Connection
------------
1. Create a Customer Gateway

2. Create a Virtual Private Gateway

If you configure CloudFront to serve HTTPS requests using Server Name Indication (SNI), CloudFront associates your alternate domain name with an IP address for each edge location, but the IP address is not dedicated to your distribution. When a viewer submits an HTTPS request for your content, DNS routes the request to the IP address for the applicable edge location. However, because the IP address isn't dedicated to your distribution, CloudFront can't determine, based on the IP address, which domain the request is for.

When you're using a custom origin, the SSL/TLS certificate on your origin includes a domain name in the Common Name field, and possibly several more in the Subject Alternative Names field. (CloudFront supports wildcard characters in certificate domain names.)

One of the domain names in the certificate must match the domain name that you specify for Origin Domain Name. If no domain name matches, CloudFront returns HTTP status code 502 (Bad Gateway) to the viewer.



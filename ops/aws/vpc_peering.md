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

VPC
------------
On AWS, when you create a VPC, it spans all AZs in the region, After creating a VPC, you can add one or more subnets in each Availability Zone. When you create a subnet, you specify the CIDR block for the subnet, which is a subset of the VPC CIDR block. Each subnet must reside entirely within one Availability Zone and cannot span zones

VPC Peering
--------------
A VPC peering connection is a networking connection between two VPCs that enables you to route traffic between them using private IPv4 addresses or IPv6 addresses. Instances in either VPC can communicate with each other as if they are within the same network. You can create a VPC peering connection between your own VPCs, or with a VPC in another AWS account. In both cases, the VPCs must be in the same region.

 it is neither a gateway nor a VPN connection, and does not rely on a separate piece of physical hardware. There is no single point of failure for communication or a bandwidth bottleneck.

1. The owner of the requester VPC sends a request to the owner of the accepter VPC to create the VPC peering connection.
2. The owner of the accepter VPC accepts the VPC peering connection request to activate the VPC peering connection
3.  the owner of each VPC in the VPC peering connection must add a route to one or more of their VPC's route tables that points to the IP address range of the other VPC (the peer VPC).

The failed VPC peering connection remains visible to the requester for 2 hours.

The charges for transferring data within a VPC peering connection are the same as the charges for transferring data across Availability Zones

You cannot create a VPC peering connection between VPCs in different regions.

You cannot have more than one VPC peering connection between the same two VPCs at the same time.

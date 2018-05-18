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

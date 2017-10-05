th an Elastic IP address, you can mask the failure of an instance or software by rapidly remapping the address to another instance in your account.

An Elastic IP address is a public IPv4 address, which is reachable from the Internet. If your instance does not have a public IPv4 address, you can associate an Elastic IP address with your instance to enable communication with the Internet

When you associate an Elastic IP address with an instance or its primary network interface, the instance's public IPv4 address (if it had one) is released back into Amazon's pool of public IPv4 addresses. You cannot reuse a public IPv4 address.

A disassociated Elastic IP address remains allocated to your account until you explicitly release it. An Elastic IP address is for use in a specific region only.

When you associate an Elastic IP address with an instance that previously had a public IPv4 address, the public DNS hostname of the instance changes to match the Elastic IP address.
We resolve a public DNS hostname to the public IPv4 address or the Elastic IP address of the instance outside the network of the instance, and to the private IPv4 address of the instance from within the network of the instance.

EC2-VPC
When you allocate an Elastic IP address, it's for use only in a VPC.

An Elastic IP address is a property of a network interface. You can associate an Elastic IP address with an instance by updating the network interface attached to the instance. For more information, see Elastic Network Interfaces.





But, since Eureka Servers are the ones that help you identify other services with changing hostnames, you need a standard set of well identifiable addresses for Eureka Servers.

That is where AWS EC2 Elastic IP addresses come in handy. This is a must read if you have not heard about Elastic IP addresses before.

o, you need one Elastic IP for every server in the cluster. Once you configure your Eureka Server with the list of elastic ip address, Eureka server deals with the hassle of finding the elastic ip that is unused and binds it to itself during the start up.

You normally have one ASG for a Eureka cluster within an AWS Region and the instance launches configured to spread equally across all zones. 

The new server will pick a free Elastic IP from that zone and bind itself there. For clients that are accessing Eureka Servers, this is transparent and business as usual as the eureka clients automatically failover to other servers and then reconnect again when the server comes back up.

we would like to add new zones or new Eureka servers transparently and hence we use the DNS model to allocate the new EIPs and the both the clients and servers find them on the fly. A simpler model would be to define them in the Eureka configuration files, but the drawback is, they get baked into the AMI and distributed to probably 1000's of instances that need to talk to each other and adding or removing zones can be extremely cumbersome, because you need to deploy the new AMI with changed configurations to all the clients.


u first configure a DNS name for region that can be used to find the list of available zones. Since, using DNS you can find only one CNAME for a DNS name, we use the TXT records to find a list DNS names.

For instance, following is a DNS TXT record created in the DNS server that lists the set of available DNS names for a zone.

txt.us-east-1.mydomaintest.netflix.net="us-east-1c.mydomaintest.netflix.net" 
"us-east-1d.mydomaintest.netflix.net" "us-east-1e.mydomaintest.netflix.net"

Then, you can define TXT records recursively for each zone similar to the following (if more than one hostname per zone, space delimit)

txt.us-east-1c.mydomaintest.netflix.net="ec2-552-627-568-165.compute-1.amazonaws.com" 
"ec2-368-101-182-134.compute-1.amazonaws.com"
txt.us-east-1d.mydomaintest.netflix.net="ec2-552-627-568-170.compute-1.amazonaws.com"
txt.us-east-1e.mydomaintest.netflix.net="ec2-500-179-285-592.compute-1.amazonaws.com"


 you specify the following properties in the Eureka Server (eureka-client.properties) and also in all the Eureka clients for them to be able to look up DNS and find the information necessary for communication.

eureka.shouldUseDns=true
eureka.eurekaServer.domainName=mydomaintest.netflix.net
eureka.eurekaServer.port=7001
eureka.eurekaServer.context=eureka/v2

Eureka servers communicate with one another using these URLs and each URL contains a public hostname (ec2-552-627-568-170.compute-1.amazonaws.com) which is derived from an Elastic IP (552.627.568.170).

How does Eureka find unused EIPs? It uses the Eureka client to find the list of peer instances and see what EIPS they are bound with and picks the one that is not bound. It prefers to find the EIP assigned to its zone, so that the Eureka clients of the all the other instances in the zone can talk to Eureka server that are co-located in the same zone. If the Eureka server cannot find any EIPS free for its zone, it tries the EIPs assigned in other zones. If all of them are bound, then the Eureka server starts up and waits for an EIP to become free and tries every 5 mins to bind the EIP.

The Eureka clients similarly try to find a Eureka server co-located in the same zone and if they do not find any, they fail over to the Eureka servers in the other zones.

In the AWS cloud environment, pass in the java commandline property -Deureka.datacenter=cloud so that the Eureka Client/Server knows to initialize the information specific to AWS cloud.

alternatively you can explicitly set the AWS accessId and secretKey via configurations:
   eureka.awsAccessId=
   eureka.awsSecretKey=

ASG??

When you associate an Elastic IP address with an instance or its primary network interface, the instance's public IPv4 address (if it had one) is released back into Amazon's pool of public IPv4 addresses. You cannot reuse a public IPv4 address.

A disassociated Elastic IP address remains allocated to your account until you explicitly release it. An Elastic IP address is for use in a specific region only.

When you associate an Elastic IP address with an instance that previously had a public IPv4 address, the public DNS hostname of the instance changes to match the Elastic IP address.
We resolve a public DNS hostname to the public IPv4 address or the Elastic IP address of the instance outside the network of the instance, and to the private IPv4 address of the instance from within the network of the instance.

EC2-VPC
When you allocate an Elastic IP address, it's for use only in a VPC.

An Elastic IP address is a property of a network interface. You can associate an Elastic IP address with an instance by updating the network interface attached to the instance. For more information, see Elastic Network Interfaces.



In the AWS cloud environment, pass in the java commandline property -Deureka.datacenter=cloud so that the Eureka Client/Server knows to initialize the information specific to AWS cloud.

alternatively you can explicitly set the AWS accessId and secretKey via configurations:
   eureka.awsAccessId=
   eureka.awsSecretKey=

-----------
once you have added your EC2 instances to your cluster and then add the first task definition/docker container (Terrible choice of names AWS). Discovery with Eureka works, however it registers with the internal Docker container. Ok, no problem. Just use the — net=”host”. Then you discover ECS does not support that capability.

the workaround involved adding a bash script to the docker container to discover the settings of its Host Instance.

Task is an individual instance of a given docker container

Eureka works fine with AWS ESC if we have static Docker port. We just need expose this port then Eureka can resolve AWS host using AmazonInfo (http://cloud.spring.io/spring-cloud-netflix/spring-cloud-netflix.html#_using_eureka_on_aws)

But Eureka doesn’t help you if you want to use ECS autoscalling feature.

Actually, we can use Eureka with ECS(autoscalling) and Docker only with Docker network host (docker run --net=host). But this approach is not good. For Kubernetes it’s OK, because each Docker image is isolated in Pod(some Kubernetes expert mentioned that they are going to remove Eureka, because Kubernetes itself can do all this stuff

We have solved that by enabling the docker rest api on the ecs host. You can then create an introspector that asks the docker daemon on the host for the port mapping and use that info in a custom Eureka instance config bean.



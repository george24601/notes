Confluent Cloud has a web interface and local command line interface. You can manage cluster resources, settings, and billing with the web interface. You can use Confluent Cloud CLI to create and manage Kafka topics.

```
cat ~/.ccloud/config
ssl.endpoint.identification.algorithm=https
sasl.mechanism=PLAIN
request.timeout.ms=20000
bootstrap.servers=<bootstrap-server-url>
retry.backoff.ms=500
sasl.jaas.config=org.apache.kafka.common.security.plain.PlainLoginModule required username="<kafka-api-key>" password="<kafka-api-secret>";
security.protocol=SASL_SSL

// Schema Registry specific settings
basic.auth.credentials.source=USER_INFO
schema.registry.basic.auth.user.info=<schema-registry-api-key>:<schema-registry-api-secret>
schema.registry.url=<schema-registry-url>

// Enable Avro serializer with Schema Registry (optional)
key.serializer=io.confluent.kafka.serializers.KafkaAvroSerializer
value.serializer=io.confluent.kafka.serializers.KafkaAvroSerializer
```

Verify that your Schema Registry credentials are properly configured, where Schema Registry API key (<schema-registry-api-key>), API secret (<schema-registry-api-secret>), and endpoint (<schema-registry-url>) are specified.


99.95% Uptime

Confluent provides Terraform scripts to aid developers working with Confluent Cloud to provision tools from Confluent Platform automatically, such as Schema Registry, REST Proxy, Kafka Connect, KSQL and Control Center. Once provisioned, these tools are connected to the Confluent Cloud cluster.

These scripts handle creating the underlying infrastructure details, like VPC, Subnets, Firewalls, Storage, Compute, Load Balancers, as well as bootstrapping any processes that are necessary to install and configure the Confluent Platform tools.

The following diagram shows an example of what is created by the scripts. Everything related to the infrastructure is managed by the script, including the VPC, subnets, firewall rules, storage, compute and the load balancers that expose the tools. The tools are created in private subnets with no internet access whatsoever. Inbound access is possible only through the public load balancers, which ensures that the tools are secured within the VPC. The link with the Confluent Cloud cluster is done automatically for you. Finally, the script also manages the scale-out process through multiple availability zones.

The scripts also provides the ability to provision a bastion server, which might be used to perform local troubleshooting in the compute instances. Since the compute instances are created within private subnets, there is no way to access them directly via SSH. The compute instances are created with firewall rules that give SSH access to the compute instances only from the bastion server. By default, the bastion server is not created, so you need to enable it explicitly to use it.

You can create VPCs with private IP CIDR (Classless Inter-Domain Routing) blocks and run your instances inside the VPCs on these private networks. The VPC can include applications and all of your cloud services. You can then peer your VPCs with Confluent VPCs so that you can access Confluent Cloud within the linked private networks.

f you use VPC peering, your clusters will not have public endpoints and you can only access them from peered VPCs.
After a cluster has been provisioned with VPC peering, you cannot change the VPC peering details.


You cannot directly connect from an on-premises datacenter to Confluent Cloud. To do so, you must first land in a shared services VPC that you own that is peered to Confluent. Transitive VPC peering is not supported. For more information about how to configure your Amazon Web Services (AWS) VPCs to achieve transitivity across VPCs, see Multiple-VPC VPN Connection Sharing.

If you use VPC peering, your clusters will not have public endpoints and you can only access them from peered VPCs.
After a cluster has been provisioned with VPC peering, you cannot change the VPC peering details.

Provide the following information to your Confluent representative.

The account ID associated with the VPC that you are peering to Confluent.
The VPC ID that you are peering with Confluent.
The AWS region of the VPC that you are peering with Confluent. This must be the same region as the Confluent Cloud cluster.
The VPC CIDR or list of CIDRs for your side. You cannot use a CIDR in 198.18.0.0/15 or 10.255.0.0/16.
The VPC CIDR for the Confluent side will be provided by Confluent. It will come from the 198.18.0.0/15 netblock.
You must have route tables to Confluent CIDR block.
You must have security group rules that allow traffic to the Confluent CIDR block.

If you have VPC peered environment and you want to use Confluent Cloud Schema Registry, you must open outbound calls (egress) to a public Schema Registry endpoint. This is because Confluent Cloud Schema Registry is a multi-tenant Schema Registry.



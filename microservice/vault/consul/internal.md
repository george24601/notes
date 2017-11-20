We define a datacenter to be a networking environment that is private, low latency, and high bandwidth. This excludes communication that would traverse the public internet, but for our purposes multiple availability zones within a single EC2 region would be considered part of a single datacenter.

. Serf provides membership, failure detection, and event broadcast. Our use of these is described more in the gossip documentation. It is enough to know that gossip involves random node-to-node communication, primarily over UDP.

the work of detecting node failures is not placed on the servers but is distributed. This makes failure detection much more scalable than naive heartbeating schemes. Thirdly, it is used as a messaging layer to notify when important events such as leader election take place

In general, data is not replicated between different Consul datacenters

The gossip protocol used by Serf is based on "SWIM: Scalable Weakly-consistent Infection-style Process Group Membership Protocol",

Entropy is the tendency of systems to become increasingly disordered.

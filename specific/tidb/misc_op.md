If you want to see the PD latency of getting tso, you could see the PD TSO RPC Duration. The PD TSO Wait Duration actually contains the PD TSO RPC Duration. The “Wait” here is actually the asynchronous wait time, that is, the time from the asynchronous acquisition of the TSO to the time when the transaction actually needs to use the TSO to read/write data. In general, the time to get the TSO is earlier than the time it takes to use it. The name of this indicator is somewhat confusing.

From me: PD TSO RPC duration, 99 at 1.74 ms makes way more sense

EKS CNI plugin allocates many private IPs for pods on a node by default. If the subnet CIDR is too small, it will soon be worn out.

WARM_IP_TARGET Type: Integer Default: None Specifies the number of free IP addresses that the ipamD daemon should attempt to keep available for pod assignment on the node. For example, if WARM_IP_TARGET is set to 10, then ipamD attempts to keep 10 free IP addresses available at all times. If the elastic network interfaces on the node are unable to provide these free addresses, ipamD attempts to allocate more interfaces until WARM_IP_TARGET free IP addresses are available. This environment variable overrides WARM_ENI_TARGET behavior.

You can set this environment variable to a small value or increase the subnet CIDR

Is the dashboard a TiKV dashboard? If so, this is by design, the storage available size is reported by TiKV server and TiKV server only consume one NVMe SSD now.

Question on modifying monitoring services: currently if you change any monitoring service configs (with persistence enabled), k8s will try to rolling restart but it’ll get stuck because EBS is attached to the old ReplicaSet. We can manually delete the old ReplicaSet to force restart (with some downtime)
Yes, EBS is ReadWriteOnce, StatefulSet is a solution, also, change the upgrade strategy of monitor deployment to recreate should work.

TiDB alert rules are configured in Prometheus not Grafana.

Currently, the alert rules are defined in the configmap, this can be changed by kubectl edit configmap
The alertmanager is not managed by tidb-operator, users should deploy and configure alertmanager themselves. And usually only one alertmanager is needed for the whole platform
We’ll deploy promtheus-operator in our cluster too.

the dynamic expansion makes it easy to manage monitor services. But we haven't tested the dynamic expansion of EBS storage yet, some cloud storage needs to reboot to expand the cloud disk. We're not sure if EBS supports online expansion. We'll try and test it.
So the expanded EBS volume goes from one node to another node to let pod reboot. Users have to manually delete the pod.

Another way is to use SHARD_ROW_ID_BITS instead of int primary key

Seems this query already uses an index to speed the read performance. Could you post the slow log of this query? Or can you run explain analyze select ... and share the result?


## FengChao payment
Migration process:
* Check tidb: 
  * turn off auto retry
  * verify tidb GC time
  * auto analyze time to 0.3, 
  * set max_execution_time    
* DM from mysql to tidb, real time data verification
* Verification and testing: DBreplay/gopacket real time traffic, 
* data duo dir sync: clear tidb, dm data single dir, data real time, dbreplay real time traffic replay
* Grey: timed analyze table, real tiem comparison, switch back to mysql

DBReplay
* get mysql packet
* analyze mysql protocol
* mysql command back to the file
* multiX replay
* based on gopacket
* tcp copy doesn't work for long connection

Example prod:
* c5.4xlarge x4: 16, 32, 8GB (EBS) (for both TiDB and PD)
* i3.4xlarge x10: 16, 122, 1900GB x2 (ephemeral) (for TiKV)

TiDB is going to be deployed in 2 parts using a Helm Chart; tidb-operator and tidb-cluster.
tidb-operator consists of:
ReplicaSets of:
tidb-controller-manager
tidb-scheduler

tidb-cluster consists of:
StatefulSets of:
pd
tidb
tikv
ReplicaSets of:
discovery
monitor


Because TiDB by default will use lots of file descriptors, the worker node and its Docker daemon's ulimit must be configured to greater than 1048576:

zhihu: 40k writes per sec peak, 30k+ qps P99 = 25ms, 
DM + lighting import 1 tri for 4 days

xiaohongshu: write latency LT 20ms, 10 tikv + 3pd
write 5k per sec, batch size LT 100 seems good enough

EKS CNI plugin allocates many private IPs for pods on a node by default. If the subnet CIDR is too small, it will soon be worn out.

Question on modifying monitoring services: currently if you change any monitoring service configs (with persistence enabled), k8s will try to rolling restart but it’ll get stuck because EBS is attached to the old ReplicaSet. We can manually delete the old ReplicaSet to force restart (with some downtime)
Yes, EBS is ReadWriteOnce, StatefulSet is a solution, also, change the upgrade strategy of monitor deployment to recreate should work.

the dynamic expansion makes it easy to manage monitor services. But we haven't tested the dynamic expansion of EBS storage yet, some cloud storage needs to reboot to expand the cloud disk. We're not sure if EBS supports online expansion. We'll try and test it.
So the expanded EBS volume goes from one node to another node to let pod reboot. Users have to manually delete the pod.

Tidb Operator to k8s is like bash to OS

watch out for the case where index and shard data are not on the same shard : two cases where double scan won't be a problem! 

For macOS, you need to allocate 2+ CPU and 4G+ Memory to Docker. For details, see Docker for Mac configuration.

 Allthough TiDB Operator can use network volume to persist TiDB data, this is slower due to redundant replication. It is highly recommended to set up local volume for better performance.

Note: Network volumes in a multi availability zone setup require Kubernetes v1.12 or greater. We do recommend using networked volumes for backup in the tidb-bakup chart.

TiDB Operator uses PersistentVolume to persist TiDB cluster data (including the database, monitor data, backup data), so the Kubernetes must provide at least one kind of persistent volume. To achieve better performance, local SSD disk persistent volume is recommended. You can follow this step to auto provisioning local persistent volumes.

Because TiDB by default will use lots of file descriptors, the worker node and its Docker daemon's ulimit must be configured to greater than 1048576:

The resource limits should be equal or bigger than the resource requests, it is suggested to set limit and request equal to get Guaranteed QoS.

When a pod is pending, it means the required resources are not satisfied. The most common cases are:
* CPU, memory or storage insufficient
* Storage class not exist or no PV available
* By default TiDB service is exposed using NodePort. You can modify it to ClusterIP which will disable access from outside of the cluster. Or modify it to LoadBalancer if the underlining Kubernetes supports this kind of service.
* Due to the above reasons, it's recommended to do horizontal scaling other than vertical scaling when workload increases.
* To scale in/out TiDB cluster, just modify the replicas of PD, TiKV and TiDB in values.yaml file.

By default the monitor data is not persistent, when the monitor pod is killed for some reason, the data will be lost. This can be avoided by specifying monitor.persistent to true in values.yaml file.


Use CRD to create customized TidbCLuster, customized controller to implement TiDB op logic. 

Local PV, uses special rules for failover, 

graceful shutown and ecti-leader-scheduler

when one machine is down, the Pod's local PV may not be restored => stateful set itself is not enough

in k8s cases, to do IOPS isolation, have to use one PV one physical disk. Bind mount does not support volume and IOPS separation

K8s cross region is done via Federation, still weak

use admission webhook to gracefully handle online and offline of nodes

google's db at 100ms to 150ms latency

PV/Statefulset is not a good soltion

Flash sale is not a good candiate for new sql db

Operator uses k8s TPR API, and encapsultate system op domain into the operator

operator injected into k8s, and will observe the cluster's status, and hook kubernetes cluster's status, and analyze inside Operator

use k8s resource to have a local disk resource management

1. create a k8s config map, i.e., tidb storage , storage's physical resoruce inside config, e.g., machine's IP, disk's corresponding folder
2. create a  tidb-volume TPR, this resources uses that config map to read the physical disk status from the config map, i.e., converts the disk resources into a TPR too
3. create a volume controller to mark the usage status of the resources, VC also montiors config maps physical resource in RT
4. pakcage the local disk resource boot instances
5. create daemonseta to mtainit disk's resource usage,e.g., a tikv node is down, you need to delete and clear data. 

SS defines the identity of pods inside the group, boot and upgrade will follow a particular order, and useds PV to store data.

When the node failed pod needs migration, the corresponding PV will be loaded. Note PV is based on distributed file system

When the pod migrteas, the ip address will change, SS can use bound domain name to guarantee pod's identity does not change

Due to security concernts, load network PV to other nodes is dangerous,e.g., double write due to eager write

operator is a k8s controller, which uses a spec to guide its behavior

1. User create/update TidbCluster object via k8s API server by helm
2. TiDB operator use `watch API server`'s tidb cluster create/update/delete. Maintains PD/TiKV/TiDB StatefulSet, Service, Deployment
 

Operater to k8s is like bash to OS

K8s no local storage because to them network disk is common and normal, e.g., if service is down, start a new container, and attach volumn to the new pod

To elaborate: TiDB's patch to K8s => similar to DCOS's batch script

http://t.cn/RKqwDNu
watch out for the case where index and shard data are not on the same shard : two cases where double scan won't be a problem! 

TiDB Operator empowers TiDB with horizontal scalability on the cloud.

Users can deploy and manage multiple TiDB clusters on a single Kubernetes cluster easily.

TiDB Operator automatically performs failover for your TiDB cluster when node failures occur.

Automatically deploy Prometheus, Grafana for TiDB cluster monitoring.

op

For macOS, you need to allocate 2+ CPU and 4G+ Memory to Docker. For details, see Docker for Mac configuration.

 Allthough TiDB Operator can use network volume to persist TiDB data, this is slower due to redundant replication. It is highly recommended to set up local volume for better performance.

Note: Network volumes in a multi availability zone setup require Kubernetes v1.12 or greater. We do recommend using networked volumes for backup in the tidb-bakup chart.

TiDB Operator uses PersistentVolume to persist TiDB cluster data (including the database, monitor data, backup data), so the Kubernetes must provide at least one kind of persistent volume. To achieve better performance, local SSD disk persistent volume is recommended. You can follow this step to auto provisioning local persistent volumes.

Because TiDB by default will use lots of file descriptors, the worker node and its Docker daemon's ulimit must be configured to greater than 1048576:


The resource limits should be equal or bigger than the resource requests, it is suggested to set limit and request equal to get Guaranteed QoS.


When a pod is pending, it means the required resources are not satisfied. The most common cases are:

CPU, memory or storage insufficient

Storage class not exist or no PV available

By default TiDB service is exposed using NodePort. You can modify it to ClusterIP which will disable access from outside of the cluster. Or modify it to LoadBalancer if the underlining Kubernetes supports this kind of service.

Due to the above reasons, it's recommended to do horizontal scaling other than vertical scaling when workload increases.

To scale in/out TiDB cluster, just modify the replicas of PD, TiKV and TiDB in values.yaml file.

To scale up/down TiDB cluster, modify the cpu/memory/storage limits and requests of PD, TiKV and TiDB in values.yaml file.


TiDB cluster is monitored with Prometheus and Grafana. When TiDB cluster is created, a Prometheus and Grafana pod will be created and configured to scrape and visualize metrics.

By default the monitor data is not persistent, when the monitor pod is killed for some reason, the data will be lost. This can be avoided by specifying monitor.persistent to true in values.yaml file.


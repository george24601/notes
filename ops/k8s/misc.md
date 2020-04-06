#container
Build container:
Dev container + build dependencies
Source can be from mounted volume or directly read into docker as container builting process
Builder container will create the final service container,i.e., init the service container and inject the built code.
Notice that build process will NOT handle different environment varaibles between deployment environment. That is part of release process

Service container: what goes to production - environment variables. most likely from an image
Little difference from dev container. Should bulit code be inside container or mounted? No clear disadvantage of inside container 

Test container:
service container + testing dependencies + environment variables for testing.

Installation container:
package service container with env vars, builds a container image that goes to production


# Pod
pod consists of one or more containers that are guaranteed to be co-located on the host machine and can share resources.

Each pod in Kubernetes is assigned a unique IP address within the cluster, which allows applications to use ports without the risk of conflict

A Pod represents a running process on your cluster.

Containers inside a Pod can communicate with one another using localhost

Restarting a container in a Pod should not be confused with restarting the Pod. The Pod itself does not run, but is an environment the containers run in and persists until it is deleted.

while it is possible to use Pod directly, it’s far more common in Kubernetes to manage your pods using a Controller. In general, Controllers use a Pod Template that you provide to create the Pods for which it is responsible.

Subsequent changes to the template or even switching to a new template has no direct effect on the pods already created. Similarly, pods created by a replication controller may subsequently be updated directly.

# Deployment

A Deployment controller provides declarative updates for Pods and ReplicaSets.

You describe a desired state in a Deployment object, and the Deployment controller changes the actual state to the desired state at a controlled rate.

Deployment - An API object that manages a replicated application.  

You can run a stateful application by creating a Kubernetes Deployment and connecting it to an existing PersistentVolume using a PersistentVolumeClaim.

# Service

By itself, a Deployment can’t receive traffic.

Kubernetes provides service discovery and request routing by assigning a stable IP address and DNS name to the service, and load balances traffic in a round-robin manner to network connections of that IP address among the pods matching the selector. By default a service is exposed inside a cluster, but a service can also be exposed outside a cluster.

Services generally abstract access to Kubernetes Pods, but they can also abstract other kinds of backends. For example:

You want to have an external database cluster in production, but in test you use your own databases.

You want to point your service to a service in another Namespace or on another cluster.

You are migrating your workload to Kubernetes and some of your backends run outside of Kubernetes.

For example, if you have a Service called "my-service" in Kubernetes Namespace "my-ns" a DNS record for "my-service.my-ns" is created. Pods which exist in the "my-ns" Namespace should be able to find it by simply doing a name lookup for "my-service". Pods which exist in other Namespaces must qualify the name as "my-service.my-ns". The result of these name lookups is the cluster IP.

ClusterIP: Exposes the service on a cluster-internal IP. Choosing this value makes the service only reachable from within the cluster.

Kubernetes services perform health checks on the default pod port and endpoint "/". If you don't have that endpoint mapped or if it's secured, you need to include livenessProbe and readinessProbe configuration

#k8s DNS server

The DNS server watches the Kubernetes API for new Services and creates a set of DNS records for each

When you create a Service, it creates a corresponding DNS entry. This entry is of the form <service-name>.<namespace-name>.svc.cluster.local, which means that if a container just uses <service-name>, it will resolve to the service which is local to a namespace.

#Ingress

An API object that manages external access to the services in a cluster, typically HTTP.

Edge router: A router that enforces the firewall policy for your cluster. This could be a gateway managed by a cloud provider or a physical piece of hardware.



Kubelet is responsible for the running state of each node, ensuring that all containers on the node are healthy. It takes care of starting, stopping, and maintaining application containers organized into pods as directed by the control plane.

The Kube-proxy is an implementation of a network proxy and a load balancer, and it supports the service abstraction along with other networking operation. It is responsible for routing traffic to the appropriate container based on IP and port number of the incoming request.

cAdvisor is an agent that monitors and gathers resource usage and performance metrics such as CPU, memory, file and network usage of containers on each node.

kube-scheduler: Component on the master that watches newly created pods that have no node assigned, and selects a node for them to run on.
Namespaced addon objects are created in the kube-system namespace.

A Cluster-level logging mechanism is responsible for saving container logs to a central log store with search/browsing interface.

Container Resource Monitoring records generic time-series metrics about containers in a central database, and provides a UI for browsing that data.

the Status of the Ready condition is “Unknown” or “False” for longer than the pod-eviction-timeout, an argument is passed to the kube-controller-manager and all of the Pods on the node are scheduled for deletion by the Node Controller.

Kubernetes will create a node object internally (the representation), and validate the node by health checking based on the metadata.name field (we assume metadata.name can be resolved). If the node is valid, i.e. all necessary services are running, it is eligible to run a pod; otherwise, it will be ignored for any cluster activity until it becomes valid. Note that Kubernetes will keep the object for the invalid node unless it is explicitly deleted by the client, and it will keep checking to see if it becomes valid.

When running in a cloud environment, whenever a node is unhealthy, the node controller asks the cloud provider if the VM for that node is still available. If not, the node controller deletes the node from its list of nodes.

StatefulSets are best suited for scenarios where replicas (Pods) need to coordinate their workloads in a strongly consistent manner. Guaranteeing an identity for each Pod helps avoid split-brain side effects in the case when a node becomes unreachable (network partition). This makes StatefulSets a great fit for distributed datastores like Cassandra or Elasticsearch.

Why not use round-robin DNS?


In order to store the state of your cluster, and the representation of your cluster, we need to create a dedicated S3 bucket for kops to use. This bucket will become the source of truth for our cluster configuration. 

We STRONGLY recommend versioning your S3 bucket in case you ever need to revert or recover a previous state store.

An instance group is a set of instances, which will be registered as kubernetes nodes. On AWS this is implemented via auto-scaling-groups.

#log

As such, logs should have a separate storage and lifecycle independent of nodes, pods, or containers. This concept is called cluster-level-logging. Cluster-level logging requires a separate backend to store, analyze, and query logs. Kubernetes provides no native storage solution for log data, but you can integrate many existing logging solutions into your Kubernetes cluster.

For example, the Docker container engine redirects those two streams to a logging driver, which is configured in Kubernetes to write to a file in json format.

Note: The Docker json logging driver treats each line as a separate message. When using the Docker logging driver, there is no direct support for multi-line messages. You need to handle multi-line messages at the logging agent level or higher.

By default, if a container restarts, the kubelet keeps one terminated container with its logs. If a pod is evicted from the node, all corresponding containers are also evicted, along with their logs.

Kubernetes currently is not responsible for rotating logs, but rather a deployment tool should set up a solution to address that. For example, in Kubernetes clusters, deployed by the kube-up.sh script, there is a logrotate tool configured to run each hour. You can also set up a container runtime to rotate application’s logs automatically, e.g. by using Docker’s log-opt. In the kube-up.sh script, the latter approach is used for COS image on GCP, and the former approach is used in any other environment. In both cases, by default rotation is configured to take place when log file exceeds 10MB.

As an example, you can find detailed information about how kube-up.sh sets up logging for COS image on GCP in the corresponding script.

When you run kubectl logs as in the basic logging example, the kubelet on the node handles the request and reads directly from the log file, returning the contents in the response.

Currently, if some external system has performed the rotation, only the contents of the latest log file will be available through kubectl logs. E.g. if there’s a 10MB file, logrotate performs the rotation and there are two files, one 10MB in size and one empty, kubectl logs will return an empty response.

Commonly, the logging agent is a container that has access to a directory with log files from all of the application containers on that node.

Using a node-level logging agent is the most common and encouraged approach for a Kubernetes cluster, because it creates only one agent per node, and it doesn’t require any changes to the applications running on the node. However, node-level logging only works for applications’ standard output and standard error.

Kubernetes doesn’t specify a logging agent, but two optional logging agents are packaged with the Kubernetes release: Stackdriver Logging for use with Google Cloud Platform, and Elasticsearch.

Both use fluentd with custom configuration as an agent on the node.

# Using a sidecar container with the logging agent

The sidecar container streams application logs to its own stdout.

The sidecar container runs a logging agent, which is configured to pick up logs from an application container.

# Sidecar container with a logging agent

Using a logging agent in a sidecar container can lead to significant resource consumption. Moreover, you won’t be able to access those logs using kubectl logs command, because they are not controlled by the kubelet.

### Annotation

 In contrast, annotations are not used to identify and select objects. The metadata in an annotation can be small or large, structured or unstructured, and can include characters not permitted by labels.

 
### reserved labels
* Example: kubernetes.io/hostname=ip-172-20-114-199.ec2.internal

Used on: Node

Kubelet populates this with the hostname. Note that the hostname can be changed from the “actual” hostname by passing the --hostname-override flag to kubelet.

* beta.kubernetes.io/instance-type=m3.medium
This can be handy if you want to target certain workloads to certain instance types, but typically you want to rely on the Kubernetes scheduler to perform resource-based scheduling, and you should aim to schedule based on properties rather than on instance types (e.g. require a GPU, instead of requiring a g2.2xlarge)

* failure-domain.beta.kubernetes.io/zone=us-east-1c

Used on: Node, PersistentVolume

On the Node: Kubelet populates this with the zone information as defined by the cloudprovider. It will not be set if not using a cloudprovider, but you should consider setting it on the nodes if it makes sense in your topology.

On the PersistentVolume: The PersistentVolumeLabel admission controller will automatically add zone labels to PersistentVolumes, on GCE and AWS

Kubernetes will automatically spread the pods in a replication controller or service across nodes in a single-zone cluster (to reduce the impact of failures). With multiple-zone clusters, this spreading behaviour is extended across zones (to reduce the impact of zone failures). This is achieved via SelectorSpreadPriority

We assume that the different zones are located close to each other in the network, so we don’t perform any zone-aware routing. In particular, traffic that goes via services might cross zones (even if some pods backing that service exist in the same zone as the client), and this may incur additional latency and cost.


### Control plane

The various parts of the Kubernetes Control Plane, such as the Kubernetes Master and kubelet processes, govern how Kubernetes communicates with your cluster. The Control Plane maintains a record of all of the Kubernetes Objects in the system, and runs continuous control loops to manage those objects’ state. At any given time, the Control Plane’s control loops will respond to changes in the cluster and work to make the actual state of all the objects in the system match the desired state that you provided.

The Kubernetes master is responsible for maintaining the desired state for your cluster. When you interact with Kubernetes, such as by using the kubectl command-line interface, you’re communicating with your cluster’s Kubernetes master.

The “master” refers to a collection of processes managing the cluster state. Typically all these processes run on a single node in the cluster, and this node is also referred to as the master. The master can also be replicated for availability and redundancy

The nodes in a cluster are the machines (VMs, physical servers, etc) that run your applications and cloud workflows. The Kubernetes master controls each node; you’ll rarely interact with nodes directly.

###Eviction

The value for memory.available is derived from the cgroupfs instead of tools like free -m. This is important because free -m does not work in a container, and if users use the node allocatable feature, out of resource decisions are made local to the end user Pod part of the cgroup hierarchy as well as the root node. 


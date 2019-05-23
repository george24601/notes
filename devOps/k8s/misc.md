# Pod
pod consists of one or more containers that are guaranteed to be co-located on the host machine and can share resources.

Each pod in Kubernetes is assigned a unique IP address within the cluster, which allows applications to use ports without the risk of conflict

A Pod represents a running process on your cluster.

Containers inside a Pod can communicate with one another using localhost

Restarting a container in a Pod should not be confused with restarting the Pod. The Pod itself does not run, but is an environment the containers run in and persists until it is deleted.

while it is possible to use Pod directly, it’s far more common in Kubernetes to manage your pods using a Controller. In general, Controllers use a Pod Template that you provide to create the Pods for which it is responsible.

Subsequent changes to the template or even switching to a new template has no direct effect on the pods already created. Similarly, pods created by a replication controller may subsequently be updated directly.

# Controller

A controller is a reconciliation loop that drives actual cluster state toward the desired cluster state

The set of pods that constitute a service are defined by a label selector. 

Logically, each controller is a separate process, but to reduce complexity, they are all compiled into a single binary and run in a single process.

Node Controller: Responsible for noticing and responding when nodes go down.
Replication Controller: Responsible for maintaining the correct number of pods for every replication controller object in the system.
Endpoints Controller: Populates the Endpoints object (that is, joins Services & Pods).
Service Account & Token Controllers: Create default accounts and API access tokens for new namespaces.

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
Kubernetes also supports DNS SRV (service) records for named ports. If the "my-service.my-ns" Service has a port named "http" with protocol TCP, you can do a DNS SRV query for "_http._tcp.my-service.my-ns" to discover the port number for "http"

When you create a Service, it creates a corresponding DNS entry. This entry is of the form <service-name>.<namespace-name>.svc.cluster.local, which means that if a container just uses <service-name>, it will resolve to the service which is local to a namespace.

#Ingress

An API object that manages external access to the services in a cluster, typically HTTP.

Edge router: A router that enforces the firewall policy for your cluster. This could be a gateway managed by a cloud provider or a physical piece of hardware.

#Resource requests & limits
CPU and memory are collectively referred to as compute resources, or just resources. Compute resources are measurable quantities that can be requested, allocated, and consumed. They are distinct from API resources. API resources, such as Pods and Services are objects that can be read and modified through the Kubernetes API server.

Although requests and limits can only be specified on individual Containers, it is convenient to talk about Pod resource requests and limits. A Pod resource request/limit for a particular resource type is the sum of the resource requests/limits of that type for each Container in the Pod.

The kubelet uses liveness probes to know when to restart a Container.

The kubelet uses readiness probes to know when a Container is ready to start accepting traffic. A Pod is considered ready when all of its Containers are ready


Kubelet is responsible for the running state of each node, ensuring that all containers on the node are healthy. It takes care of starting, stopping, and maintaining application containers organized into pods as directed by the control plane.

Kubelet monitors the state of a pod, and if not in the desired state, the pod re-deploys to the same node. Node status is relayed every few seconds via heartbeat messages to the master. Once the master detects a node failure, the Replication Controller (note the replicationcontroller is the old way now - use Deployment and ReplicaSet now! ) observes this state change and launches pods on other healthy nodes.

The Kube-proxy is an implementation of a network proxy and a load balancer, and it supports the service abstraction along with other networking operation. It is responsible for routing traffic to the appropriate container based on IP and port number of the incoming request.

cAdvisor is an agent that monitors and gathers resource usage and performance metrics such as CPU, memory, file and network usage of containers on each node.

To make updates to your cluster’s state, you submit these files to the Kubernetes API server (kube-apiserver).

kube-scheduler: Component on the master that watches newly created pods that have no node assigned, and selects a node for them to run on.
Namespaced addon objects are created in the kube-system namespace.

A Cluster-level logging mechanism is responsible for saving container logs to a central log store with search/browsing interface.

Container Resource Monitoring records generic time-series metrics about containers in a central database, and provides a UI for browsing that data.

The status describes the actual state of the object, and is supplied and updated by the Kubernetes system.

the Status of the Ready condition is “Unknown” or “False” for longer than the pod-eviction-timeout, an argument is passed to the kube-controller-manager and all of the Pods on the node are scheduled for deletion by the Node Controller.

What this means is that when Kubernetes creates a node, it is really just creating an object that represents the node. After creation, Kubernetes will check whether the node is valid or not

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


# Pod
pod consists of one or more containers that are guaranteed to be co-located on the host machine and can share resources.

Each pod in Kubernetes is assigned a unique IP address within the cluster, which allows applications to use ports without the risk of conflict

A Pod represents a running process on your cluster.

Containers inside a Pod can communicate with one another using localhost

Restarting a container in a Pod should not be confused with restarting the Pod. The Pod itself does not run, but is an environment the containers run in and persists until it is deleted.

while it is possible to use Pod directly, it’s far more common in Kubernetes to manage your pods using a Controller. In general, Controllers use a Pod Template that you provide to create the Pods for which it is responsible.

Subsequent changes to the template or even switching to a new template has no direct effect on the pods already created. Similarly, pods created by a replication controller may subsequently be updated directly.

if you want to check the logs of a pod you can use the kubectl log

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

Service - An API object that describes how to access applications, such as a set of Pods, and can describe ports and load-balancers.  - By itself, a Deployment can’t receive traffic.

Kubernetes provides service discovery and request routing by assigning a stable IP address and DNS name to the service, and load balances traffic in a round-robin manner to network connections of that IP address among the pods matching the selector (even as failures cause the pods to move from machine to machine). By default a service is exposed inside a cluster (e.g. back end pods might be grouped into a service, with requests from the front-end pods load-balanced among them), but a service can also be exposed outside a cluster (e.g. for clients to reach frontend pods).

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



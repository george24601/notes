tidb cluster charts -> helm -> 

graceful shutown and ecti-leader-scheduler

use admission webhook to gracefully handle online and offline of nodes

use k8s resource to have a local disk resource management

SS defines the identity of pods inside the group, boot and upgrade will follow a particular order, and useds PV to store data.

When the node failed pod needs migration, the corresponding PV will be loaded. Note PV is based on distributed file system

When the pod migrteas, the ip address will change, SS can use bound domain name to guarantee pod's identity does not change

1. User create/update TidbCluster object via k8s API server by helm
2. TiDB operator use `watch API server`'s tidb cluster create/update/delete. Maintains PD/TiKV/TiDB StatefulSet, Service, Deployment
 
include automatic backup and restore => hooks to k8s status, and sends analystical stuff inside k8s

every time stopping the service, let controller notify cluster to do the data migration off the node => need to implement a controller and inside controller's constorl to check if pod can be shutdown gracefully

Alternavite: ValidationAdmissionWebhook NOte k8s AdmissionControler is simliar to filter or middleware
Dynamic admiision control very powerful

If you want to use a different envirnoment, a proper DNS addon must be installed in the Kubernetes cluster. You can follow the k8s official documentation to set up a DNS addon.

The Kubernetes cluster is suggested to enable (k8s)RBAC. Otherwise you may want to set rbac.create to false in the values.yaml of both tidb-operator and tidb-cluster charts

Because TiDB by default will use lots of file descriptors, the worker node and its Docker daemon's ulimit must be configured to greater than 1048576

```bash
sudo vim /etc/systemd/system/docker.service
```

The resource limits should be equal or bigger than the resource requests, it is suggested to set limit and request equal to get Guaranteed QoS.

For other settings, the variables in values.yaml are self-explanatory with comments. You can modify them according to your need before installing the charts.

By default TiDB service is exposed using NodePort. You can modify it to ClusterIP which will disable access from outside of the cluster. Or modify it to LoadBalancer if the underlining Kubernetes supports this kind of service.


Interesting default configs:
* pvReclaimPolicy: Retain
* pd service is exposed via ClusterIP
* discovery pulls the tidb-operator image
* pd storageClassName: local-storage (in the context of k8s)
* tikv storageClassName: local-storage (in the context of k8s)

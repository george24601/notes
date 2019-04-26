graceful shutown and ecti-leader-scheduler

K8s cross region is done via Federation, still weak

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

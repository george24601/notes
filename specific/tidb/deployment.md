### Dev

* 2 * TiDB: 16 core + 32G RAM
* 3 * TiKV: 16 core + 32G RAM 200 - 300 G SSD
* 3 * PD: 4 core + 8G RAM + 100 G+ SSD

### New Prod

Minimum:
* 2 * TiDB: 32 core + 64G RAM
* 3 * TiKV: 32 core + 64G RAM 200 - 500 G SSD
* 3 * PD: 8 core + 16G RAM + 200 G+ SSD

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

from google pov, can accept latency of network drive => inspires persistent volumne. on average google's db write latency is 100 - 150 ms

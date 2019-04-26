### Prod deployment
* 2 * TiDB: 32 core + 64G RAM
* 3 * TiKV: 32 core + 64G RAM 200 - 500 G SSD
* 3 * PD: 8 core + 16G RAM + 200 G+ SSD

Candidate AWS instances: r3.2xlarge with instanceStore

Test environment: 1 TiDB, 1 PD - colocated, 3 TiKV 

active standby is being phased out, all HA stuff is done based on concensus instead of replication

Because TiDB by default will use lots of file descriptors, the worker node and its Docker daemon's ulimit must be configured to greater than 1048576:

100+ machine requires automated ops

from google pov, can accept latency of network drive => inspires persistent volumneo. on average google's db write latency is 100 - 150 ms

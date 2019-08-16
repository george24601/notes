Network partition can be simulated by change the VPC route tables to blackhole in each subnet's AZ. In the order of severity

default 30 mins in replensih replica
1. bring back asap
2. if can't be recovered, set the store to Offline state (via pdctl?)

### One PD instance is down 
* Wait for the self recovery, how to verify that new instance is in the quorum? Grafana? logs?

### One Tikv instance is down
* Wait for the self recovery, how to verify that new instance is in the quorum? Grafana? logs?

### Pump is down
* How to ensure that the new pump will join the pump cluster correctly?
* In this context, we still need to clear the old pump metadata?

### drainer is down
* How to ensure that the new pump will join the pump cluster correctly?
* In this context, we still need to clear the old pump metadata?

### Incremental backup drill
* daily snapshot during downtime -> need to measure the time to backup and restore
* additional drainer writes to the local file

### Quorum down
* try restarting the whole cluster? 
* provision a new one?
* active-standby cluster in a different EKS?
* In any case, we need to use incremental backup to ensure RPO = 0

### One AZ down
* should be self healing
* Just wait until it recovers, if more AZs are done, go to the quorum case

###Qs 
* what is the pump & drainer's disk size?
* How to verify the health of PD cluster?
* How to verify the health of TiKV cluster?
	
### TODO
* sounds like we need a standby cluster, (second stage)

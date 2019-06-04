uses Service catalog. External services to surface into k8s like pod or stateful set

CRDB running as stateful set 

helm to deliver DBs

velero??

declarative environment

micro.yaml 

```
name:db
type:service
kind:crdb
plan:development
timeout:600
(more than this)
```

declarative backup plan

They didn't do:
* No multi-tenenancy within a single DB. No noisy neighbor
* no fine-grained access control

20 production instances - paying for yourself
150 non prod instances

PVCs are only created by StatefulSets, not deleted. Need to clean up PVCs manually
take a backup before you take out any PVC

exec-based lievess and readniess probe: into a container and assess the health of the container, make sure includes your timeout command in the exec bash!

SIGTERM comes immediately, meanwhile, inside termination grace period, but the LB will keep sending - add a pre-stop hook to every pod we want 0 downtime, preStep: sleep for 30 secs

stateful sets: slot based
what if you want to replace with number consistent - you don't want to use the zero pod








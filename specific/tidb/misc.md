Note it does not support SP, View, trigger, UDF, FK 

100+ machine requires automated ops

operator for k8s? => use k8s's TPR API to encapsulate ops domain knowledge into the operator, and then inject the module to the k8s

include automatic backup and restore => hooks to k8s status, and sends analystical stuff inside k8s

from google pov, can accept latency of network drive => inspires persistent volumneo

active standby is being phased out, all HA stuff is done based on concensus instead of replication

on average google's db write latency is 100 - 150 ms

incremental id is good, NOT good for flash sale use case.

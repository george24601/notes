1. kubernetes_state.pod.status_phase. To sum by `phase` to get number of pods in a given phase, and `namespace` to break this down by namespace. Note this actually means "pod ready" in the default dashboard.

2. kubernetes.pods.running. Can break it down over hosts

3. kubernetes.cpu.usage.total. can break it down over hosts, can order by usage

4. kubernetes.memory.usage. can break it down over hosts, can order by usage 

5. kubernetes.memory.request. 
e.g., 

6. kubernets.cpu.request

7. kubernetes_state.deployment.replicas_unavailable, unavailable pods



kube-state-metrics also reports kube_node_status_allocatable_cpu_cores and kube_node_status_allocatable_memory_bytes tracking respectively the CPU and memory resources of each node that are available for scheduling. Note that these metrics don’t track actual reservation and are not impacted by current scheduling operations. They are equal to the remaining resource available in the node capacity once you remove the amount of resource dedicated to system processes (journald, sshd, kubelet, kube-proxy, etc…).

The CPU throttling metric is a great example, as it represents the number of times a container hit its specified limit.

And one of Heapster’s limitations is that it collects Kubernetes metrics at a different frequency (aka “housekeeping interval”) than cAdvisor, which makes the overall metric collection frequency for metrics reported by Heapster tricky to evaluate. This can lead to inaccuracies due to mismatched sampling intervals, especially for metrics where sampling is crucial to the value of the metric, such as counts of CPU time. That’s why you should really consider tracking metrics from your containers instead of from Kubernetes.

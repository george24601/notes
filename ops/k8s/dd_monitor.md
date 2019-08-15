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

The percentage of disk in use is generally more useful than the volume of disk usage, since the thresholds of concern won’t depend on the size of your clusters. You should graph its evolution over time and trigger an alert if it exceeds 80% for example.

Just as with ordinary hosts, you should monitor network metrics from your pods and containers.

And one of Heapster’s limitations is that it collects Kubernetes metrics at a different frequency (aka “housekeeping interval”) than cAdvisor, which makes the overall metric collection frequency for metrics reported by Heapster tricky to evaluate. This can lead to inaccuracies due to mismatched sampling intervals, especially for metrics where sampling is crucial to the value of the metric, such as counts of CPU time. That’s why you should really consider tracking metrics from your containers instead of from Kubernetes.

After the aggregation method you can determine what constitutes a line or grouping in a graph. If you choose host, then you have a line (in the case of line graphs) for every host. If you choose role, then there is a line for every role. Then that line is made up of metrics from all the hosts in that role, aggregated using the method you chose above.

Regardless of the options chosen above, there is always some aggregation of data due to the physical size constraints of the window holding the graph. If a metric is updated every second and you are looking at 4 hours of data, you need 14,400 points to display everything. Each graph we display has about 300 points shown at any given time.

In the example above, each point displayed on the screen represents 48 data points. In practice, metrics are collected by the Agent every 15-20 seconds. So one day’s worth of data is 4,320 data points. You might consider a rollup(?!) function that looks at 5 or 10 minutes worth of data if you would like to have more control over the display of your data for a graph that shows 1 day.


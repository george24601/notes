1. kubernetes_state.pod.status_phase. To sum by `phase` to get number of pods in a given phase, and `namespace` to break this down by namespace. Note this actually means "pod ready" in the default dashboard.

2. kubernetes.pods.running. Can break it down over hosts

3. kubernetes.cpu.usage.total. can break it down over hosts, can order by usage

4. kubernetes.memory.usage. can break it down over hosts, can order by usage 

5. kubernetes.memory.request. 
e.g., 

6. kubernets.cpu.request

7. kubernetes_state.deployment.replicas_unavailable, unavailable pods


kube_deployment_spec_replicas, kube_deployment_status_replicas_available
-
You should make sure the number of available pods always matches the desired number of pods outside of expected deployment transition phases

Keeping an eye on the number of pods currently running (by node or replica set, for example) will give you an overview of the evolution of your dynamic infrastructure.

To understand how the number of running pods impacts resource usage (CPU, memory, etc.) in your cluster, you should correlate this metric with the resource metrics described in the next section.

o track memory and CPU usage you should favor the metrics reported by your container technology, such as Docker, rather than the Kubernetes statistics reported by Heapster.

kube-state-metrics also reports kube_node_status_allocatable_cpu_cores and kube_node_status_allocatable_memory_bytes tracking respectively the CPU and memory resources of each node that are available for scheduling. Note that these metrics don’t track actual reservation and are not impacted by current scheduling operations. They are equal to the remaining resource available in the node capacity once you remove the amount of resource dedicated to system processes (journald, sshd, kubelet, kube-proxy, etc…).

That’s why monitoring the sum of requests on the node and making sure it never exceeds your node’s capacity is much more important than monitoring simple CPU or memory usage.

The CPU throttling metric is a great example, as it represents the number of times a container hit its specified limit.

The percentage of disk in use is generally more useful than the volume of disk usage, since the thresholds of concern won’t depend on the size of your clusters. You should graph its evolution over time and trigger an alert if it exceeds 80% for example.

Just as with ordinary hosts, you should monitor network metrics from your pods and containers.

Kubernetes labels are already applied to Docker metrics. You could track for example the number of running containers by pod, or the most RAM-intensive pods by graphing the RSS non-cache memory broken down by pod name.

Remember that Docker metrics should be preferred to Kubernetes for time-sampled data. So let’s graph the CPU utilization by Docker containers, broken down by pod (or container) and filtered to retain only the pods with the label rc-nginx.

And one of Heapster’s limitations is that it collects Kubernetes metrics at a different frequency (aka “housekeeping interval”) than cAdvisor, which makes the overall metric collection frequency for metrics reported by Heapster tricky to evaluate. This can lead to inaccuracies due to mismatched sampling intervals, especially for metrics where sampling is crucial to the value of the metric, such as counts of CPU time. That’s why you should really consider tracking metrics from your containers instead of from Kubernetes.

Even when you are using Docker metrics, however, you should still aggregate them using the labels from Kubernetes.

The performance metrics you track won’t be attached to hosts as they were before, but aggregated around labels that you will use to group or filter the pods you are interested in. So make sure to define a logical and easy-to-understand schema for your labels, and create clear labels within your namespaces.




After the aggregation method you can determine what constitutes a line or grouping in a graph. If you choose host, then you have a line (in the case of line graphs) for every host. If you choose role, then there is a line for every role. Then that line is made up of metrics from all the hosts in that role, aggregated using the method you chose above.

Regardless of the options chosen above, there is always some aggregation of data due to the physical size constraints of the window holding the graph. If a metric is updated every second and you are looking at 4 hours of data, you need 14,400 points to display everything. Each graph we display has about 300 points shown at any given time.

In the example above, each point displayed on the screen represents 48 data points. In practice, metrics are collected by the Agent every 15-20 seconds. So one day’s worth of data is 4,320 data points. You might consider a rollup(?!) function that looks at 5 or 10 minutes worth of data if you would like to have more control over the display of your data for a graph that shows 1 day.



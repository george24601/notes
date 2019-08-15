To effectively monitor containers, you also need to tag (label) your containers.

Rather than instructing your system to monitor a particular host or container, you can instruct your system to monitor everything that shares a common property (tag)—for example, all containers located in the same availability zone.

1. user CPU:Percent of time that CPU is under direct control of processes
2. system CPU:Percent of time that CPU is executing system calls on behalf of processes
3. throttling (count):Number of CPU throttling enforcements for a container
4. throttling (time):Total time that a container's CPU usage was throttled

unlike a traditional host, Docker does not report nice, idle, iowait, or irq CPU time.

For memories:

1. Memory.Memory usage of a container

2. RSS.Non-cache memory for a process (stacks, heaps, etc.).RSS (resident set size) is data that belongs to a process: stacks, heaps, etc. RSS itself can be further decomposed into active and inactive memory (active_anon and inactive_anon). Inactive RSS memory is swapped to disk when necessary.

3. Cache memory.Data from disk cached in memory. Cache can be further decomposed into active and inactive memory (active_file, inactive_file). Inactive memory may be reclaimed first when the system needs memory.

4. Swap.Amount of swap space in use

used memory = RSS + cache memory

I/O part skiped for now!

Network part skipped for now!

Out of the box, Datadog collects CPU, memory, I/O, and network metrics from each Docker container, and can aggregate metrics by any tag or tags.

Datadog breaks down network traffic by image and container so their engineers can immediately see exactly which service is overloaded or causing other services to fail by sending too much traffic—and they can aggregate these service metrics across any number of hosts.

docker.net.bytes_rcvd

docker.net.bytes_sent


the Datadog Agent uses the native cgroup accounting metrics to gather CPU, memory, network and I/O metrics of the containers every 15 seconds before they are forwarded to Datadog.

By default, the agent will monitor your containers and turn the Docker “name”, “image” and “command” attributes into a “tag”.

docker.cpu.user - can be broken down by image

to create a multi-alert on the docker.mem.rss metric and Datadog will trigger an alert if any container misbehaves.

sample tag -- image:redis:2.8

Much like any other meaningful event in your infrastructure, you can search for Docker container create/start/stop/destroy events using the Events Stream. Simply use “sources:docker” as the search filter.



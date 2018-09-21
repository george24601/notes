Tags are converted to lowercase.

For optimal functionality, we recommend constructing tags that use the key:value syntax.

device, host, and source are reserved tag keys and cannot be specified in the standard way
You can also enter tags: followed by a tag to see all the events that come from a host or integration with that tag. The example in the image is the tag role:cassandra. So the search text is tags:role:cassandra

A custom metric refers to a single, unique combination of a metric name, host, and any tags.

Note that the ordering of tags does not matter

The format for sending metrics is metric.name:value|type|@sample_rate|#tag1:value,tag2,

Metric types: 

1. Gauges:  value of a particular thing over time. If called multiple times during a check’s execution for a metric only the last sample is used.

2. Rate: it’s the value variation of a metric on a defined time interval.Submit the sampled raw value of your counter. Don’t normalize the values to a rate, or calculate the deltas before submitting - the Agent does both for you. Should only be called once during a check.
Throws away any value that is less than a previously submitted value. IE the counter should be monotonically increasing.
Stored as a GAUGE type in the Datadog web application. Each value in the stored timeseries is a time-normalized delta of the counter’s value between samples.

#work metrics

When considering your work metrics, it’s often helpful to break them down into four subtypes:

throughput is the amount of work the system is doing per unit time. Throughput is usually recorded as an absolute number. e.g.,requests per second

success metrics represent the percentage of work that was executed successfully. e.g., percentage of responses that are 2xx since last measurement

error metrics capture the number of erroneous results, usually expressed as a rate of errors per unit time or normalized by the throughput to yield errors per unit of work. Error metrics are often captured separately from success metrics when there are several potential sources of error, some of which are more serious or actionable than others.e.g., percentage of responses that are 5xx since last measurement

performance metrics quantify how efficiently a component is doing its work. The most common performance metric is latency, which represents the time required to complete a unit of work. Latency can be expressed as an average or as a percentile, such as “99% of requests returned within 0.1s”. e.g., 90th percentile response time in seconds

# Resource metrics

utilization is the percentage of time that the resource is busy, or the percentage of the resource’s capacity that is in use.

saturation is a measure of the amount of requested work that the resource cannot yet service, often queued. e.g., # enqueued requests

errors represent internal errors that may not be observable in the work the resource produces.

availability represents the percentage of time that the resource responded to requests. This metric is only well-defined for resources that can be actively and regularly checked for availability.

some monitoring systems can also capture events: discrete, infrequent occurrences that can provide crucial context for understanding what changed in your system’s behavior. Some examples:

Changes: Internal code releases, builds, and build failures
Alerts: Internally generated alerts or third-party notifications
Scaling events: Adding or subtracting hosts

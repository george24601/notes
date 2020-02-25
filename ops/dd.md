If you change Simple Alert to Multi Alert, you can set up a monitor on each separate timeseries in a group. For example, you could monitor the system.cpu.user metric for each host individually, rather than monitoring the average of that metric across all the hosts:

Monitoring a sparse metric?

Heat maps are purpose-built to clearly render overlapping timeseries—one of their principal features is the use of shading to represent the number of entities reporting a metric in a specific range.

Note that the ordering of tags does not matter

The format for sending metrics is metric.name:value|type|@sample_rate|#tag1:value,tag2,

Rate metric: it’s the value variation of a metric on a defined time interval.Submit the sampled raw value of your counter. Don’t normalize the values to a rate, or calculate the deltas before submitting - the Agent does both for you. Should only be called once during a check.
Throws away any value that is less than a previously submitted value. IE the counter should be monotonically increasing.
Stored as a GAUGE type in the Datadog web application. Each value in the stored timeseries is a time-normalized delta of the counter’s value between samples.

# Resource metrics

utilization is the percentage of time that the resource is busy, or the percentage of the resource’s capacity that is in use.

saturation is a measure of the amount of requested work that the resource cannot yet service, often queued. e.g., # enqueued requests

errors represent internal errors that may not be observable in the work the resource produces.

availability represents the percentage of time that the resource responded to requests. This metric is only well-defined for resources that can be actively and regularly checked for availability.

some monitoring systems can also capture events: discrete, infrequent occurrences that can provide crucial context for understanding what changed in your system’s behavior. Some examples:

Changes: Internal code releases, builds, and build failures
Alerts: Internally generated alerts or third-party notifications
Scaling events: Adding or subtracting hosts

#monitors

Keep in mind that anomalies uses the past to predict what is expected in the future, so using anomalies on a new metric, for which you have just started collecting data, may yield poor results.

All of the seasonal algorithms (i.e., excluding basic) may use up to a couple of months of historical data when calculating a metric’s expected normal range of behavior. By using a significant amount of past data, the algorithms are able to avoid giving too much weight to abnormal behavior that might have occurred in the recent past.

#Anti-patterns

One of the most common goals in monitoring is understanding the behavior of groups. Whether it’s a group of servers, containers, or devices, you want to monitor several entities doing the same job. Ideally, you want to see overall group performance in aggregate, while also keeping an eye on individual performance.

At first glance, a stacked area graph like the one above seems perfect for this use case

Use an aggregate timeseries graph for the big picture…
A single series showing the sum of group behavior is a much cleaner and more responsive way of tracking aggregate behavior than a sumptuous-looking but ultimately messy phyllo graph.

Plus a focused look at individual behavior
To highlight individual behavior, you can then complement the aggregate graph with some combination of the following graphs:

Use a heat map to reveal general group trends and help you spot outliers

Use a host map to show what is happening across the group right now and to segment your group by any relevant attribute.

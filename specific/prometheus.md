How is meterregistry implemented with the system metrics?

Prometheus scrapes metrics from instrumented jobs, either directly or via an intermediary push gateway for short-lived jobs. It stores all scraped samples locally and runs rules over this data to either aggregate and record new time series from existing data or generate alerts.

 Each Prometheus server is standalone, not depending on network storage or other remote services.

 Prometheus values reliability. You can always view what statistics are available about your system, even under failure conditions. If you need 100% accuracy, such as for per-request billing, Prometheus is not a good choice as the collected data will likely not be detailed and complete enough. In such a case you would be best off using some other system to collect and analyze the data for billing, and Prometheus for the rest of your monitoring.

 Yes, run identical Prometheus servers on two or more separate machines. Identical alerts will be deduplicated by the Alertmanager.

 streams of timestamped values belonging to the same metric and the same set of labeled dimensions. Besides stored time series, Prometheus may generate temporary derived time series as the result of queries.

 Every time series is uniquely identified by its metric name and optional key-value pairs called labels.

 P*'s pushes alerts to alert manager

 Instant vector - a set of time series containing a single sample for each time series, all sharing the same timestamp
Range vector - a set of time series containing a range of data points over time for each time series

in the simplest form, only a metric name is specified. This results in an instant vector containing elements for all time series that have this metric name.

Range vector literals work like instant vector literals, except that they select a range of samples back from the current instant. Syntactically, a range duration is appended in square brackets ([]) at the end of a vector selector to specify how far back in time values should be fetched for each resulting range vector element.

when constructing queries over unknown data, always start building the query in the tabular view of Prometheus's expression browser until the result set seems reasonable (hundreds, not thousands, of time series at most).

where a bare metric name selector like api_http_requests_total could expand to thousands of time series with different labels.




50% storage and 80% CPU are used by a couple high dimension metrics

```
//check metric's number of time series, alert if it is over 10k
count by(__name__)({__name__=~".+"}) > 10000

```

rate first and then sum

Recording rule should get the values to be calced directly, AVOID mid result and then aggregate

rate(v range-vector) calculates the per-second average rate of increase of the time series 

per-second rate of HTTP requests as measured over the last 5 minutes, per time series in the range vector
rate(http_requests_total{job="api-server"}[5m])

Note that when combining rate() with an aggregation operator (e.g. sum()) or a function aggregating over time (any function ending in over_time), always take a rate() first, then aggregate

counters only go up and reset. This has implications for what order you apply operations in.

 A counter starts at 0, and is incremented. The client does no other calculations. At each scrape Prometheus takes a sample of this state. The rate() function in Prometheus looks at the history of time series over a time period, and calculates how fast it's increasing per second. This can handle multiple Prometheus servers taking samples, and if a scrape fails you'll lose resolution but not data as on the next successful scrape the increments haven't been lost or averaged away.

 Any time a counter appears to decrease it'll be treated as though there was a reset to 0 right after the first data point. This makes it important that it not be possible for Counters to be decremented, a Counter that has the potential to be decremented is in reality a Gauge

 Assuming that the http_requests_total time series all have the labels job (fanout by job name) and instance (fanout by instance of the job), we might want to sum over the rate of all instances, so we get fewer output time series, but still preserve the job dimension:

 ```
 sum by (job) (
  rate(http_requests_total[5m])
)
```

Ingested samples are grouped into blocks of two hours. Each two-hour block consists of a directory containing one or more chunk files that contain all time series samples for that window of time, as well as a metadata file and index file (which indexes metric names and labels to time series in the chunk files).

Ingested samples are grouped into blocks of two hours. Each two-hour block consists of a directory containing one or more chunk files that contain all time series samples for that window of time, as well as a metadata file and index file (which indexes metric names and labels to time series in the chunk files).

On average, Prometheus uses only around 1-2 bytes per sample.

The expression browser is available at /graph on the Prometheus server, allowing you to enter any expression and see its result either in a table or graphed over time.

As a general rule, for every line of logging code you should also have a counter that is incremented. If you find an interesting log message, you want to be able to see how often it has been happening and for how long.

It is also generally useful to export the total number of info/error/warning lines that were logged by the application as a whole, and check for significant differences as part of your release process.

Each labelset is an additional time series

As a general guideline, try to keep the cardinality of your metrics below 10

To give you a better idea of the underlying numbers, let's look at node_exporter. node_exporter exposes metrics for every mounted filesystem. Every node will have in the tens of timeseries for, say, node_filesystem_avail. If you have 10,000 nodes, you will end up with roughly 100,000 timeseries for node_filesystem_avail, which is fine for Prometheus to handle.

If you were to now add quota per user, you would quickly reach a double digit number of millions with 10,000 users on 10,000 nodes. This is too much for the current implementation of Prometheus.

The key class is the Collector. This has a method (typically called ‘collect’) that returns zero or more metrics and their samples. Collectors get registered with a CollectorRegistry. Data is exposed by passing a CollectorRegistry to a class/method/function "bridge", which returns the metrics in a format Prometheus supports. Every time the CollectorRegistry is scraped it must callback to each of the Collectors’ collect method.

CollectorRegistry SHOULD offer register()/unregister() functions, and a Collector SHOULD be allowed to be registered to multiple CollectorRegistrys.

Client libraries MUST be thread safe.

There MUST be a default CollectorRegistry, the standard metrics MUST by default implicitly register into it with no special work required by the user. There MUST be a way to have metrics not register to the default CollectorRegistry, for use in batch jobs and unittests. Custom collectors SHOULD also follow this.

As noted above, the result of labels() should be cacheable. The concurrent maps that tend to back metric with labels tend to be relatively slow. Special-casing metrics without labels to avoid labels()-like lookups can help a lot.

Metrics SHOULD avoid blocking when they are being incremented/decremented/set etc. as it’s undesirable for the whole application to be held up while a scrape is ongoing.

Having benchmarks of the main instrumentation operations, including labels, is ENCOURAGED.

Resource consumption, particularly RAM, should be kept in mind when performing exposition. Consider reducing the memory footprint by streaming results, and potentially having a limit on the number of concurrent scrapes.

When implementing the collector for your exporter, you should never use the usual direct instrumentation approach and then update the metrics on each scrape.

Rather create new metrics each time. In Go this is done with MustNewConstMetric in your Collect() method. For Python see https://github.com/prometheus/client_python#custom-collectors and for Java generate a List<MetricFamilySamples> in your collect method, see StandardExports.java for an example.

The reason for this is two-fold. Firstly, two scrapes could happen at the same time, and direct instrumentation uses what are effectively file-level global variables, so you’ll get race conditions. Secondly, if a label value disappears, it’ll still be exported.

Each exporter should monitor exactly one instance application, preferably sitting right beside it on the same machine. That means for every HAProxy you run, you run a haproxy_exporter process. For every machine with a Mesos worker, you run the Mesos exporter on it, and another one for the master, if a machine has both.

The theory behind this is that for direct instrumentation this is what you’d be doing, and we’re trying to get as close to that as we can in other layouts. This means that all service discovery is done in Prometheus, not in exporters. This also has the benefit that Prometheus has the target information it needs to allow users probe your service with the blackbox exporter.

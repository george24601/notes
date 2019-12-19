run identical Prometheus servers on two or more separate machines. Identical alerts will be deduplicated by the Alertmanager.

streams of timestamped values belonging to the same metric and the same set of labeled dimensions. Besides stored time series, Prometheus may generate temporary derived time series as the result of queries.

Every time series is uniquely identified by its metric name and optional key-value pairs called labels.

P*'s pushes alerts to alert manager

Instant vector - a set of time series containing a single sample for each time series, all sharing the same timestamp
Range vector - a set of time series containing a range of data points over time for each time series

in the simplest form, only a metric name is specified. This results in an instant vector containing elements for all time series that have this metric name.

Range vector literals work like instant vector literals, except that they select a range of samples back from the current instant.

when constructing queries over unknown data, always start building the query in the tabular view of Prometheus's expression browser until the result set seems reasonable (hundreds, not thousands, of time series at most).

where a bare metric name selector like api_http_requests_total could expand to thousands of time series with different labels.


50% storage and 80% CPU are used by a couple high dimension metrics

rate first and then sum

Recording rule should get the values to be calced directly, AVOID mid result and then aggregate

rate(v range-vector) calculates the per-second average rate of increase of the time series 

Note that when combining rate() with an aggregation operator (e.g. sum()) or a function aggregating over time (any function ending in over_time), always take a rate() first, then aggregate

counters only go up and reset. This has implications for what order you apply operations in.

 Any time a counter appears to decrease it'll be treated as though there was a reset to 0 right after the first data point. This makes it important that it not be possible for Counters to be decremented, a Counter that has the potential to be decremented is in reality a Gauge

As a general rule, for every line of logging code you should also have a counter that is incremented. If you find an interesting log message, you want to be able to see how often it has been happening and for how long.

It is also generally useful to export the total number of info/error/warning lines that were logged by the application as a whole, and check for significant differences as part of your release process.

Each labelset is an additional time series

As a general guideline, try to keep the cardinality of your metrics below 10

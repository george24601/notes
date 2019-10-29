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

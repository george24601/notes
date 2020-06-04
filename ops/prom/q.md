The expression browser is available at /graph on the Prometheus server, allowing you to enter any expression and see its result either in a table or graphed over time.
--check metric's number of time series, alert if it is over 10k
count by(__name__)({__name__=~".+"}) > 10000

we select all the values we have recorded within the last 5 minutes for all time series that have the metric name http_requests_total and a job label set to prometheus:
http_requests_total{job="prometheus"}[5m]

--per-second rate of HTTP requests as measured over the last 5 minutes, per time series in the range vector
rate(http_requests_total{job="api-server"}[5m])

--Assuming that the http_requests_total time series all have the labels job (fanout by job name) and instance (fanout by instance of the job), we might want to sum over the rate of all instances, so we get fewer output time series, but still preserve the job dimension:

 sum by (job) (
  rate(http_requests_total[5m])
)

the number of HTTP requests as measured over the last 5 minutes, per time series in the range vector:
increase(http_requests_total{job="api-server"}[5m])

All of these metrics are scraped from exporters. Prometheus scrapes these metrics at regular intervals. The setting for when the intervals should occur is specified by the scrape_interval in the prometheus.yaml config. Most scrape intervals are 30s. This means that every 30s, there will be a new data point with a new timestamp. The value may or may not have changed, but at every scrape_interval, there will be a new datapoint.

rate() - calculates the per-second average rate of increase of the time series in the range vector over the whole range.

increase() - calculates the increase in the time series per the time range selected. It’s basically rate multiplied by the number of seconds in the time range selector.

The general rule for choosing the range is that it should be at least 4x the scrape interval. This is to allow for various races, and to be resilient to a failed scrape.

Increase Of Http_requests_total Averaged Over The Last 5 Minutes.
rate(http_requests_total[5m])

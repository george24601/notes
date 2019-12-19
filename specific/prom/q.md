The expression browser is available at /graph on the Prometheus server, allowing you to enter any expression and see its result either in a table or graphed over time.
--check metric's number of time series, alert if it is over 10k
count by(__name__)({__name__=~".+"}) > 10000

--per-second rate of HTTP requests as measured over the last 5 minutes, per time series in the range vector
rate(http_requests_total{job="api-server"}[5m])

--Assuming that the http_requests_total time series all have the labels job (fanout by job name) and instance (fanout by instance of the job), we might want to sum over the rate of all instances, so we get fewer output time series, but still preserve the job dimension:

 sum by (job) (
  rate(http_requests_total[5m])
)




run identical Prometheus servers on two or more separate machines. Identical alerts will be deduplicated by the Alertmanager.

P pushes alerts to alert manager

when constructing queries over unknown data, always start building the query in the tabular view of Prometheus's expression browser until the result set seems reasonable (hundreds, not thousands, of time series at most).

50% storage and 80% CPU are used by a couple high dimension metrics

Recording rule should get the values to be calced directly, AVOID mid result and then aggregate

Note that when combining rate() with an aggregation operator (e.g. sum()) or a function aggregating over time (any function ending in over_time), always take a rate() first, then aggregate

It is also generally useful to export the total number of info/error/warning lines that were logged by the application as a whole, and check for significant differences as part of your release process.

Each labelset is an additional time series

As a general guideline, try to keep the cardinality of your metrics below 10

alertmanager supports gossip


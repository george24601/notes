from datadog import initialize, statsd
import time

#assuming that datadog agent, which embeds dogstatds are installed already
options = {'statsd_host': '127.0.0.1', 'statsd_port': 8125}

initialize(**options)

tags = ["env:stg"]

for _ in range(10):
    statsd.increment('george.cnt', tags=tags)

with statsd.timed('george.timer', tags=tags):
    time.sleep(5)

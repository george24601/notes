Pages with rote, algorithmic responses should be a red flag. Unwillingness on the part of your team to automate such pages implies that the team lacks confidence that they can clean up their technical debt. This is a major problem worth escalating.

Email alerts are of very limited value and tend to easily become overrun with noise; instead, you should favor a dashboard that monitors all ongoing subcritical problems for the sort of information that typically ends up in email alerts.
* reverse proxy layer: nginx keepalived + virtual ip
* web server layer: configs web servers behind nginx
* write db: mater + shadow master with keepalived + virtual IP

Migrate redis:
* use internal DNS for quick switching IP
* kill existing connection, let CP re-estabilith the connection

simulate the machine problem by blocking the in/out port, configurable, and have a default recovery time

99.99% is a bit LT 1 hour per year
99.9% is a bit LT 9 hours per year

* regular dr drill -> find systematic risk -> optimize business system -> produce dr cookbook
* need to pass colored data in the context, but only with colored traffic. Ideally have shadow table isolation too.
* simulate error on depending service, if the impact of such failure is huge
* need to simulate traffic record/reply/isolation
* consider using prod server with no traffic

SLO vs SLA
Finally, SLAs are service level agreements: an explicit or implicit contract with your users that includes consequences of meeting (or missing) the SLOs they contain. The consequences are most easily recognized when they are financial—a rebate or a penalty—but they can take other forms. An easy way to tell the difference between an SLO and an SLA is to ask "what happens if the SLOs aren’t met?": if there is no explicit consequence, then you are almost certainly looking at an SLO.

50th, 85th, 95th, and 99th percentile latencies for a system. Note that the Y-axis has a logarithmic scale.

User studies have shown that people typically prefer a slightly slower system to one with high variance in response time, so some SRE teams focus only on high percentile values, on the grounds that if the 99.9th percentile behavior is good, then the typical experience is certainly going to be.

As a result, we’ve sometimes found that working from desired objectives backward to specific indicators works better than choosing indicators and then coming up with targets.

It’s both unrealistic and undesirable to insist that SLOs will be met 100% of the time: doing so can reduce the rate of innovation and deployment, require expensive, overly conservative solutions, or both. Instead, it is better to allow an error budget—a rate at which the SLOs can be missed—and track that on a daily or weekly basis. Upper management will probably want a monthly or quarterly assessment, too. (An error budget is just an SLO for meeting other SLOs!)

Defend the SLOs you pick: if you can’t ever win a conversation about priorities by quoting a particular SLO, it’s probably not worth having that SLO.

You can always refine SLO definitions and targets over time as you learn about a system’s behavior. It’s better to start with a loose target that you tighten than to choose an overly strict target that has to be relaxed when you discover it’s unattainable.

Users build on the reality of what you offer, rather than what you say you’ll supply, particularly for infrastructure services. If your service’s actual performance is much better than its stated SLO, users will come to rely on its current performance.

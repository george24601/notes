If you change Simple Alert to Multi Alert, you can set up a monitor on each separate timeseries in a group. For example, you could monitor the system.cpu.user metric for each host individually, rather than monitoring the average of that metric across all the hosts:

Monitoring a sparse metric?

Heat maps are purpose-built to clearly render overlapping timeseries—one of their principal features is the use of shading to represent the number of entities reporting a metric in a specific range.

Alert liberally; page judiciously

Page on symptoms, rather than causes

Alerts as records (low severity)

Alerts as notifications (moderate severity) - issues that do require intervention, but not right away. Sending an email and/or posting a notification in the service owner’s chat room is a perfect way to deliver these alerts—both message types are highly visible, but they won’t wake anyone in the middle of the night or disrupt an engineer’s flow.

In general, a page is the most appropriate kind of alert when the system you are responsible for stops doing useful work with acceptable throughput, latency, or error rates.

Paging on symptoms surfaces real, oftentimes user-facing problems, rather than hypothetical or internal problems.

Early warning metrics reflect an unacceptably high probability that serious symptoms will soon develop and require immediate intervention.

Send a page only when symptoms of urgent problems in your system’s
work are detected, or if a critical and finite resource limit is
about to be reached.
Set up your monitoring system to record alerts whenever it detects
real issues in your infrastructure, even if those issues have not
yet affected overall performance.

By and large, work metrics will surface the most serious symptoms and should therefore generate the most serious alerts



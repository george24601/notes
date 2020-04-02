Migrate redis:
* use internal DNS for quick switching IP
* kill existing connection, let CP re-estabilith the connection


Pages with rote, algorithmic responses should be a red flag. Unwillingness on the part of your team to automate such pages implies that the team lacks confidence that they can clean up their technical debt. This is a major problem worth escalating.

Email alerts are of very limited value and tend to easily become overrun with noise; instead, you should favor a dashboard that monitors all ongoing subcritical problems for the sort of information that typically ends up in email alerts.

never daemonize or write PID files. Rely on OS's process manager to manage
output, crashed processes, and user-initiated restarts and shutdowns

use of singleton process

no self-demonizing programs,or you will have to poll process list/pids

PHP processes run as child processes of Apache, started on demand as needed by request volume. Java processes take the opposite approach, with the JVM providing one massive uberprocess that reserves a large block of system resources (CPU and memory) on startup, with concurrency managed internally via threads.

never daemonize or write PID files. Rely on OS's process manager to manage
output, crashed processes, and user-initiated restarts and shutdowns

use of singleton process

no self-demonizing programs,or you will have to poll process list/pids

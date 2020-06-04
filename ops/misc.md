
never daemonize or write PID files. Rely on OS's process manager to manage
output, crashed processes, and user-initiated restarts and shutdowns

use of singleton process

no self-demonizing programs,or you will have to poll process list/pids

#### Dockers

Dev container:
More likely built from docker file than from image
Simulate production run so should have all production dependency and no dev tool installed
Code is shared via mounted volume on host system, so we can have load-on-change enabled

Dev tools container:
Do we want to do development inside docker?
If no, we can install dev tools on host, and edit the mounted volume in dev container
If yes, we need a separate container for these tools, and these tools will edit the shared volumn as well
Use it or not depending on if you need an IDE
The effectiveness of a set of tests can be measured less by their rate of problem detection and more by the rate of change that they enable.

In a world of permissionless innovation, services can and should routinely come and go. It's worth investing some effort to make it easier to deprecate services that haven't meaningfully caught on. One approach to doing this is to have a sufficiently high degree of competition for resources so that any resource-constrained team that is responsible for a languishing service is drawn to spending most of their time on other services that matter more to customers.

As this occurs, responsibility for the unsuccessful service should be transferred to the consumer who cares about it the most. This team may rightfully consider themselves to have been left "holding the can," although the deprecation decision also passes into their hands. Other teams that wish not to be left holding the can have an added incentive to migrate or terminate their dependencies. This may sound brutal, but it's an important part of "failing fast."

How is CB turned into deploy
1. build: code repo to exe bundle, a build, the build stage vendors
dependencies and compiles binaries/assents. Initialized when new code is
deployed.
2. release: takes the build and combine it with deploy's config
3. run: launch app processes against selected release. can happen
automatically,e.g., to restart the process. This stage needs to be simple so
if app fails to run, we can solve it without dev help

compile assets in build stage, instead of using filesystem as cache or JIT

app is self-contained and does not rely on the existence of web server app on the host. The only contract it has is that it binds itself to ports

One-off admin processes should be run in an identiacl environment as the regular processes against a release, same codebase and config. admin code must be shipped with application code

In local deploy, developers invoke one-off admin processes by direct shell command inside the app's checkout dir.
In production depoy, ssh into the shell to do similar thing

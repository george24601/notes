One-off admin processes should be run in an identiacl environment as the regular processes against a release, same codebase and config. admin code must be shipped with application code

In local deploy, developers invoke one-off admin processes by direct shell command inside the app's checkout dir.
In production depoy, ssh into the shell to do similar thing

graceful shutdown by SIGTERM:
1. cease to listen on service port
2. finish current request and then exit
3. client should seamlessly reconnect when connection is lsot
4. worker should return its current job back to queue. meaning the job is
reentrant,i.e., either operation's execution/writing is an all or nothing
transaction, or it is idempotent

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

Build container:
Dev container + build dependencies
Source can be from mounted volume or directly read into docker as container builting process
Builder container will create the final service container,i.e., init the service container and inject the built code.
Notice that build process will NOT handle different environment varaibles between deployment environment. That is part of release process

Service container: what goes to production - environment variables. most likely from an image
Little difference from dev container. Should bulit code be inside container or mounted? No clear disadvantage of inside container 

Test container:
service container + testing dependencies + environment variables for testing.

Installation container:
package service container with env vars, builds a container image that goes to production


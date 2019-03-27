How is CB turned into deploy
1. build: code repo to exe bundle, a build, the build stage vendors
dependencies and compiles binaries/assents. Initialized when new code is
deployed.
2. release: takes the build and combine it with deploy's config
3. run: launch app processes against selected release. can happen
automatically,e.g., to restart the process. This stage needs to be simple so
if app fails to run, we can solve it without dev help

ability to rollback a release with deployment tools

Releases are append-only ledger and immutable. Have to create a new release
for changes

Process
-----------
The twelve-factor app never assumes that anything cached in memory or on disk will be available on a future request or job – with many processes of each type running, chances are high that a future request will be served by a different process. Even when running only one process, a restart (triggered by code deploy, config change, or the execution environment relocating the process to a different physical location) will usually wipe out all local (e.g., memory and filesystem) state.

Never assume thing in memory or on disk will be available on a future request
to handle the case of multiple worker/process restart

compile assets in build stage, instead of using filesystem as cache or JIT
compiling


Sticky sessions are a violation of twelve-factor and should never be used or relied upon. Session state data is a good candidate for a datastore that offers time-expiration, such as Memcached or Redis.

---------------
app is self-contained and does not rely on the existence of web server app on the host. The only contract it has is that it binds itself to ports

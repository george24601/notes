API-oriented refactoring: hard to verify, deploy multiple endpoint at the same time - risky and difficult to rollback!

module-oriented refactoring: 

other modules calling my module: refactor mine, and change caller's logic

my module calling other modules: keep original caller, try NOT to change

win you the trust and respect of your teammates, before attempting any major rewrite

refactoring often has little visibility

The idea that new code is better than old is patently absurd. Old code has been used. It has been tested. Lots of bugs have been found, and they’ve been fixed. There’s nothing wrong with it.

when you realize there's significant functionality that is not captured in the requirements, then it's it's good idea to NOT REWRITE

Sometimes it is possible to justify working on something just by explaining technical debt and how much time it will cost in the future (e.g. slow you down).

don’t start making changes until you have a suite of tests that can spot behavior changes. There are times when things that appear to be bugs are actually weird features that the business needs to function

Start with high level integration tests of the most critical business processes. Then, work your way down to frequently used functions/classes/modules. After the whole thing is covered you can start cleaning/repairing

After that, add end-to-end, integration, then unit tests, in that order.

So for a project that lacks tests, I’d suggest higher level integration/smoke tests so that you don’t have to modularize in order to write tests. Don’t mock a database, use a “real” test database with fixtures,

wait for the person in charge to direct you towards specific repairs.

* find the dependency
* independent part
* frequent to change part
* parts requiring special resources
* facade + traffic switch
* use sidecar along with the legacy service
* use ETL to migration data to new service/code, but extra effort on that, eventual consistency, and very possible new single point of failure

* change from a local call to a local REST call
* change from the local rest to serivce rest call, note at this stage, the data is still shared
* separate data into new DB via ETL

* add an api layer on top of existing logic
* introduce BFF mode

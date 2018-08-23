API-oriented refactoring: hard to verify, deploy multiple endpoint at the same time - risky and difficult to rollback!

module-oriented refactoring: 

other modules calling my module: refactor mine, and change caller's logic

my module calling other modules: keep original caller, try NOT to change

win you the trust and respect of your teammates, before attempting any major rewrite

do not bad-mouth the original developer. I would suggest framing the issue as the code not scaling well to the new requirements

refactoring often has little visibility

The idea that new code is better than old is patently absurd. Old code has been used. It has been tested. Lots of bugs have been found, and they’ve been fixed. There’s nothing wrong with it.

when you realize there's significant functionality that is not captured in the requirements, then it's it's good idea to NOT REWRITE

Working Effectively with Legacy Code by Michael Feathers

Refactoring: Improving the Design of Existing Code

Clean Code by Uncle Bob

Sometimes it is possible to justify working on something just by explaining technical debt and how much time it will cost in the future (e.g. slow you down).

As a professional programmer, your job is not to produce beautiful code. Your job is to make money.

don’t start making changes until you have a suite of tests that can spot behavior changes. There are times when things that appear to be bugs are actually weird features that the business needs to function

Start with high level integration tests of the most critical business processes. Then, work your way down to frequently used functions/classes/modules. After the whole thing is covered you can start cleaning/repairing

After that, add end-to-end, integration, then unit tests, in that order.

Can frame it as “original author was just trying to ship quickly, and could keep track of all the hacks because they wrote them, but to bring more people onto the project it has to be made safer/easier to modify for non-experts”.

So for a project that lacks tests, I’d suggest higher level integration/smoke tests so that you don’t have to modularize in order to write tests. Don’t mock a database, use a “real” test database with fixtures,

wait for the person in charge to direct you towards specific repairs.


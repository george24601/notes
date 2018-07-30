API-oriented refactoring: hard to verify, deploy multiple endpoint at the same time - risky and difficult to rollback!

module-oriented refactoring: 

other modules calling my module: refactor mine, and change caller's logic

my module calling other modules: keep original caller, try NOT to change



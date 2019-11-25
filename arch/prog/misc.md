Service layer keeps the domain logic, which calls manager layer, which in turn calls the external/third party services

Manager is often reusable

Both service and manager layer can access dao

### How to read source code

* Start from easier ones, e.g., Spring Boot
* Read the dependency first, e.g., kafka -> zookeeper -> java.concurrent
* Create a hello world, add debug points
* Try NOT to understand every single line, just focus on the most important flow
* Draw graph
* Need to repeat this a few times to trully understand it

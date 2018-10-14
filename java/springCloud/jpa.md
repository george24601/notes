The database transaction happens inside the scope of a persistence context.

The persistence context is in JPA the EntityManager, implemented internally using an Hibernate Session (when using Hibernate as the persistence provider).

The persistence context is just a synchronizer object that tracks the state of a limited set of Java objects and makes sure that changes on those objects are eventually persisted back into the database.

This is a very different notion than the one of a database transaction. One Entity Manager can be used across several database transactions, and it actually often is.

the most frequent way to use the JPA Entity Manager is with the “Entity Manager per application transaction” pattern. @PersistenceContext

Here we are by default in “Entity Manager per transaction” mode. In this mode, if we use this Entity Manager inside a @Transactional method, then the method will run in a single database transaction.

EntityManager is an interface, and what gets injected in the spring bean is not the entity manager itself but a context aware proxy that will delegate to a concrete entity manager at runtime.

Usually the concrete class used for the proxy is SharedEntityManagerInvocationHandler, this can be confirmed with the help a debugger.

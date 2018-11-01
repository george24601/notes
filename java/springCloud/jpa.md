The database transaction happens inside the scope of a persistence context.

The persistence context is in JPA the EntityManager, implemented internally using an Hibernate Session (when using Hibernate as the persistence provider).

The persistence context is just a synchronizer object that tracks the state of a limited set of Java objects and makes sure that changes on those objects are eventually persisted back into the database.

This is a very different notion than the one of a database transaction. One Entity Manager can be used across several database transactions, and it actually often is.

the most frequent way to use the JPA Entity Manager is with the “Entity Manager per application transaction” pattern. @PersistenceContext

Here we are by default in “Entity Manager per transaction” mode. In this mode, if we use this Entity Manager inside a @Transactional method, then the method will run in a single database transaction.

EntityManager is an interface, and what gets injected in the spring bean is not the entity manager itself but a context aware proxy that will delegate to a concrete entity manager at runtime.

Usually the concrete class used for the proxy is SharedEntityManagerInvocationHandler, this can be confirmed with the help a debugger.

the class object is passed to the JPA implementation at run-time, which then extracts the annotations to generate an object-relational mapping.

It’s important to notice that JPA on itself does not provide any type of declarative transaction management. When using JPA outside of a dependency injection container, transactions need to be handled programatically by the developer

```java
UserTransaction utx = entityManager.getTransaction(); 
 
try { 
    utx.begin(); 
 
    businessLogic();
 
    utx.commit(); 
} catch(Exception ex) { 
    utx.rollback(); 
    throw ex; 
}
```

The transactional annotation itself defines the scope of a single database transaction. The database transaction happens inside the scope of a persistence context.

The persistence context is in JPA the EntityManager, implemented internally using an Hibernate Session (when using Hibernate as the persistence provider).

The persistence context is just a synchronizer object that tracks the state of a limited set of Java objects and makes sure that changes on those objects are eventually persisted back into the database.

This is a very different notion than the one of a database transaction. One Entity Manager can be used across several database transactions, and it actually often is.

What defines the EntityManager vs Transaction relation?

This is actually a choice of the application developer, but the most frequent way to use the JPA Entity Manager is with the “Entity Manager per application transaction” pattern. This is the most common way to inject an entity manager:

```java
@PersistenceContext
private EntityManager em;
Here we are by default in “Entity Manager per transaction” mode. In this mode, if we use this Entity Manager inside a @Transactional method, then the method will run in a single database transaction.
```

Probably you're also using Spring Data. Calls on Spring Data repositories are by default surrounded by a transaction, even without @EnableTransactionManagement. If Spring Data finds an existing transaction, the existing transaction will be re-used, otherwise a new transaction is created.

@Transactional annotations within your own code, however, are only evaluated when you have @EnableTransactionManagement activated (or configured transaction handling some other way).


By default, Spring Boot will enable JPA repository support and look in the package (and its subpackages) where @SpringBootApplication is located. If your configuration has JPA repository interface definitions located in a package not visible, you can point out alternate packages using @EnableJpaRepositories and its type-safe basePackageClasses=MyRepository.class parameter.



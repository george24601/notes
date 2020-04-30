UnexpectedRollbackException: when part of the txn needs to roll back beause of exception, but you swallowed the exception and the code reachs the Transactional node

Transaction boundaries are only created when properly annotated (see above) methods are called through a Spring proxy. This means that you need to call your annotated method directly through an @Autowired bean or the transaction will never start. If you call a method on an @Autowired bean that isn’t annotated which itself calls a public method that is annotated YOUR ANNOTATION IS IGNORED. This is because Spring AOP is only checking annotations when it first enters the @Autowired code.

Never blindly trust that your @Transactional annotations are actually creating transaction boundaries. When in doubt test whether a transaction really is active (see below)

If you call a method with a @Transactional annotation from a method with @Transactional within the same instance, then the called methods transactional behavior will not have any impact on the transaction. But if you call a method with a transaction definition from another method with a transaction definition, and they are in different instances, then the code in the called method will follow the transaction definitions given in the called method.

Spring declarative transaction model uses AOP proxy. so the AOP proxy is responsible for creation of the transactions. The AOP proxy will be active only if the methods with in the instance are called from out side the instance.

The default propagation level ( what you call "behavior" ) is REQUIRED. In case an "inner" method is called that has a @Transactional annotation on it ( or transacted declaratively via XML ), it will execute within the same transaction, e.g. "nothing new" is created.

@Transactional marks the transaction boundary (begin/end) but the transaction itself is bound to the thread.

If another method is called that has a @Transactional annotation then the propagation depends on the propagation attribute of that annotation.

why you would use the Spring Framework’s transaction abstraction instead of EJB Container-Managed Transactions (CMT) or choosing to drive local transactions through a proprietary API, such as Hibernate.

Global transactions let you work with multiple transactional resources, typically relational databases and message queues. The application server manages global transactions through the JTA, which is a cumbersome API

A transaction strategy is defined by the org.springframework.transaction.PlatformTransactionManager interface

the TransactionException that can be thrown by any of the PlatformTransactionManager interface’s methods is unchecked (that is, it extends the java.lang.RuntimeException class). Transaction infrastructure failures are almost invariably fatal.

The getTransaction(..) method returns a TransactionStatus object, depending on a TransactionDefinition parameter. The returned TransactionStatus might represent a new transaction or can represent an existing transaction, if a matching transaction exists in the current call stack. The implication in this latter case is that, as with Java EE transaction contexts, a TransactionStatus is associated with a thread of execution.

Propagation: Typically, all code executed within a transaction scope runs in that transaction. However, you can specify the behavior if a transactional method is executed when a transaction context already exists. For example, code can continue running in the existing transaction (the common case), or the existing transaction can be suspended and a new transaction created

Read-only status: You can use a read-only transaction when your code reads but does not modify data. Read-only transactions can be a useful optimization in some cases, such as when you use Hibernate.

The TransactionStatus interface provides a simple way for transactional code to control transaction execution and query transaction status

The related PlatformTransactionManager bean definition then has a reference to the DataSource definition

You can also use easily Hibernate local transactions, as shown in the following examples. In this case, you need to define a Hibernate LocalSessionFactoryBean, which your application code can use to obtain Hibernate Session instances.

The DataSource bean definition is similar to the local JDBC example shown previously and, thus, is not shown in the following example.

The txManager bean in this case is of the HibernateTransactionManager type. In the same way as the DataSourceTransactionManager needs a reference to the DataSource, the HibernateTransactionManager needs a reference to the SessionFactory.

Generally, you use the native ORM API or take a template approach for JDBC access by using the JdbcTemplate.

Classes such as DataSourceUtils (for JDBC), EntityManagerFactoryUtils (for JPA), SessionFactoryUtils (for Hibernate), and so on exist at a lower level. When you want the application code to deal directly with the resource types of the native persistence APIs, you use these classes to ensure that proper Spring Framework-managed instances are obtained, transactions are (optionally) synchronized, and exceptions that occur in the process are properly mapped to a consistent API. ---to expand on this...

At the very lowest level exists the TransactionAwareDataSourceProxy class. This is a proxy for a target DataSource, which wraps the target DataSource to add awareness of Spring-managed transactions

setRollbackOnly()

So, although you can still call setRollbackOnly() on the TransactionStatus object to roll back the current transaction back, most often you can specify a rule that MyApplicationException must always result in rollback.

The combination of AOP with transactional metadata yields an AOP proxy that uses a TransactionInterceptor in conjunction with an appropriate PlatformTransactionManager implementation to drive transactions around method invocations.

If you use Java-based configuration, the @EnableTransactionManagement annotation provides equivalent support . You can add the annotation to a @Configuration class.

The Spring team recommends that you annotate only concrete classes (and methods of concrete classes) with the @Transactional annotation, as opposed to annotating interfaces

Java annotations are not inherited from interfaces

@EnableTransactionManagement and <tx:annotation-driven/> looks for @Transactional only on beans in the same application context in which they are defined.

For declarative transactions, the transaction name is always the fully-qualified class name + . + the method name of the transactionally advised class.

You can use the value attribute of the @Transactional annotation to optionally specify the identity of the PlatformTransactionManager to be used. This can either be the bean name or the qualifier value of the transaction manager bean.

Advising Transactional Operations --- to expand!!!

The Spring team generally recommends the TransactionTemplate for programmatic transaction management.

You can register a regular event listener by using the @EventListener annotation. If you need to bind it to the transaction, use @TransactionalEventListener. When you do so, the listener is bound to the commit phase of the transaction by default.

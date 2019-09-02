This library allows MyBatis to participate in Spring transactions, takes care of building MyBatis mappers and SqlSessions and inject them into other beans, translates MyBatis exceptions into Spring DataAccessExceptions

To use MyBatis with Spring you need at least two things defined in the Spring application context: an SqlSessionFactory and at least one mapper interface.

In MyBatis-Spring, an SqlSessionFactoryBean is used to create an SqlSessionFactory . To configure the factory bean, put the following in the Spring XML configuration file:

Notice that the SqlSessionFactory requires a DataSource . This can be any DataSource and should be configured just like any other Spring database connection

Note that the mapper class specified must be an interface, not an actual implementation class. In this example, annotations are used to specify the SQL, but a MyBatis mapper XML file could also be used.

Once configured, you can inject mappers directly into your business/service objects in the same way you inject any other Spring bean. The MapperFactoryBean handles creating an SqlSession as well as closing it. If there is a Spring transaction in progress, the session will also be committed or rolled back when the transaction completes. Finally, any exceptions will be translated into Spring DataAccessExceptions.

Note that SqlSessionFactoryBean implements Spring's FactoryBean interface (see section 3.8 of the Spring documentation). This means that the bean Spring ultimately creates is not the SqlSessionFactoryBean itself, but what the factory returns as a result of the getObject() call on the factory. In this case, Spring will build an SqlSessionFactory for you at application startup and store it with the name sqlSessionFactory .

Specifically, any environments, data sources and MyBatis transaction managers will be ignored . SqlSessionFactoryBean creates its own, custom MyBatis Environment with these values set as required.

Another reason to require a config file is if the MyBatis mapper XML files are not in the same classpath location as the mapper classes. With this configuration, there are two options. This first is to manually specify the classpath of the XML files using a <mappers> section in the MyBatis config file. A second option is to use the mapperLocations property of the factory bean.

In case you are using the multi-db feature you will need to set the databaseIdProvider property

### transactions

One of the primary reasons for using MyBatis-Spring is that it allows MyBatis to participate in Spring transactions. Rather than create a new transaction manager specific to MyBatis, MyBatis-Spring leverages the existing DataSourceTransactionManager in Spring.

A single SqlSession object will be created and used for the duration of the transaction. This session will be committed or rolled back as appropriate when then transaction completes.

To enable Spring transaction processing, simply create a DataSourceTransactionManager in your Spring XML configuration file

Note that the DataSource specified for the transaction manager must be the same one that is used to create the SqlSessionFactoryBean or transaction management will not work.

MyBatis SqlSession provides you with specific methods to handle transactions programmatically. But when using MyBatis-Spring your beans will be injected with a Spring managed SqlSession or a Spring managed mapper. That means that Spring will always handle your transactions.

You cannot call SqlSession.commit(), SqlSession.rollback() or SqlSession.close() over a Spring managed SqlSession. If you try to do so, a UnsupportedOperationException exception will be thrown. Note these methods are not exposed in injected mapper classes.

Regardless of your JDBC connection's autocommit setting, any execution of a SqlSession data method or any call to a mapper method outside a Spring transaction will be automatically committed.

If you are using the Spring Java Configuration (a.k.a @Configuration) you would prefer to use the @MapperScan rather than the <mybatis:scan/>.

With MyBatis-Spring, you can continue to directly use the MyBatis API. Simply create an SqlSessionFactory in Spring using SqlSessionFactoryBean and use the factory in your code. Use this option with care because wrong usage may produce runtime errors or worse, data integrity problems!!! - see docs for more example





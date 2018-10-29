Polling - for other databases

MessageProducer vs DomainEventPublisher?

mysql> describe events;
+------------------+---------------+------+-----+---------+-------+
| Field            | Type          | Null | Key | Default | Extra |
+------------------+---------------+------+-----+---------+-------+
| event_id         | varchar(1000) | NO   | PRI | NULL    |       |
| event_type       | varchar(1000) | YES  |     | NULL    |       |
| event_data       | varchar(1000) | NO   |     | NULL    |       |
| entity_type      | varchar(1000) | NO   | MUL | NULL    |       |
| entity_id        | varchar(1000) | NO   |     | NULL    |       |
| triggering_event | varchar(1000) | YES  |     | NULL    |       |
| metadata         | varchar(1000) | YES  |     | NULL    |       |
| published        | tinyint(4)    | YES  | MUL | 0       |       |
+------------------+---------------+------+-----+---------+-------+

mysql> describe message;
+-------------+---------------+------+-----+---------+-------+
| Field       | Type          | Null | Key | Default | Extra |
+-------------+---------------+------+-----+---------+-------+
| id          | varchar(767)  | NO   | PRI | NULL    |       |
| destination | varchar(1000) | NO   |     | NULL    |       |
| headers     | varchar(1000) | NO   |     | NULL    |       |
| payload     | varchar(1000) | NO   |     | NULL    |       |
| published   | smallint(6)   | YES  | MUL | 0       |       |
+-------------+---------------+------+-----+---------+-------+

how is message id generated? by the IdGeneratorImpl

how about desination??

why separate column for published??

Schema is defined in EventuateSchema

The message is actually written by the MessageProducerJdbcImpl, which uses spring's standard jdbctemplate - this means we need to tweak the code for mybatis/jpa

Eventuate Tram CDC service

eventuate-tram-cdc-mysql-service, uses com.github.shyiko binlog parser, however, our past experience shows that binlog parting is flaky - not a problem for data analystics where response time is not sensitive, but critical for user-facing 

PollingCdcProcessor - 

pollingDao.findEventsToPublish

    eventsToPublish.forEach(var10001::accept);
                        if (!eventsToPublish.isEmpty()) {
                            PollingCdcProcessor.this.pollingDao.markEventsAsPublished(eventsToPublish);
                        }

spring jdbc transaction??

"SELECT * FROM %s WHERE %s = 0 ORDER BY %s ASC LIMIT :limit"

spring boot version is still on 1.3 - 1.4!

uses spring-boot-starter-jdbc

org.hibernate:hibernate-validator

Spring Data JDBC vs Spring Data JPA

JPA is a standard for Object Relational Mapping. This is a technology which allows you to map between objects in code and database tables.
The most famous JPA provider is Hibernate, so it's a good place to start for concrete examples.
Hibernate and most other providers for JPA write SQL and use JDBC to read and write from and to the DB.

Spring Data JDBC aims at being conceptually easy. In order to achieve this it does NOT offer caching, lazy loading, write behind

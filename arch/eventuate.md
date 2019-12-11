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

Schema is defined in EventuateSchema

The message is actually written by the MessageProducerJdbcImpl, which uses spring's standard jdbctemplate - this means we need to tweak the code for mybatis/jpa

PollingCdcProcessor - 

pollingDao.findEventsToPublish

    eventsToPublish.forEach(var10001::accept);
                        if (!eventsToPublish.isEmpty()) {
                            PollingCdcProcessor.this.pollingDao.markEventsAsPublished(eventsToPublish);
                        }

spring jdbc transaction??

spring boot version is still on 1.3 - 1.4!

uses spring-boot-starter-jdbc

org.hibernate:hibernate-validator

### Poller

cdcProcessor.start(cdcDataPublisher::handleEvent)

* has an AtomicBoolean(AB) as the control flag
* spawns a new thread, which runs on the while loop on this AB
* as pollingDao to get a list of events to publish 
* ask consumer to accept each event one by one
* uses a CountDownLatch to implement draining
* sender is on a exponential retry 5 times, interval starts at 1 seconds


### publisher

PollingCdcDataPublisher

  public CompletableFuture<?> send(String topic, String key, String body) {
    CompletableFuture<Object> result = new CompletableFuture<>();
    producer.send(new ProducerRecord<>(topic, key, body), (metadata, exception) -> {
      if (exception == null)
        result.complete(metadata);
      else
        result.completeExceptionally(exception);
    });
    return result;
  }

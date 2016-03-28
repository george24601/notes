#Note this one specifies offset location, which should specific to each deployment
cat ./etc/schema-registry/connect-avro-standalone.properties

#run kafka connector - standalone mode
./bin/connect-standalone ./etc/schema-registry/connect-avro-standalone.properties \
        ./etc/kafka/connect-file-source.properties

#run standalone with source and sink at the same time. Note both source and sink track their offsets
 ./bin/connect-standalone ./etc/schema-registry/connect-avro-standalone.properties \
         ./etc/kafka/connect-file-source.properties ./etc/kafka/connect-console-sink.properties

#######
#Need to set the following for distributed workers: 
#1.group.id
#2.config.storage.topic: Kafka topic to store connector and task config state. This topic should always have a single partition and be highly replicated (3x or more)!
#3.offset.storage.topic: the Kafka topic to store connector offset state in. Should have large # of partitons (25 or 50)!

bin/connect-distributed worker.properties

#distributed mode: create a connector 
curl -X POST -H "Content-Type: application/json" --data '{"name": "local-console-source", "config": {"connector.class":"org.apache.kafka.connect.file.FileStreamSourceConnector", "tasks.max":"1", "topic":"connect-test" }}' http://localhost:8083/connectors

#note if you run more than one worker per host, need to set rest.port differently for each of them

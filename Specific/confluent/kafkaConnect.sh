#Note this one specifies offset location, which should specific to each deployment
cat ./etc/schema-registry/connect-avro-standalone.properties

#connector specific settings, we will change this a lot, based on type of work
cat ./etc/kafka/connect-file-source.properties

#run kafka connector - standalone mode
./bin/connect-standalone ./etc/schema-registry/connect-avro-standalone.properties \
        ./etc/kafka/connect-file-source.properties

cat ./etc/kafka/connect-file-sink.properties

#run standalone with source and sink at the same time. Note both source and sink track their offsets
 ./bin/connect-standalone ./etc/schema-registry/connect-avro-standalone.properties \
         ./etc/kafka/connect-file-source.properties ./etc/kafka/connect-console-sink.properties


bin/connect-distributed worker.properties

#distributed mode: create a connector 
curl -X POST -H "Content-Type: application/json" --data '{"name": "local-console-source", "config": {"connector.class":"org.apache.kafka.connect.file.FileStreamSourceConnector", "tasks.max":"1", "topic":"connect-test" }}' http://localhost:8083/connectors


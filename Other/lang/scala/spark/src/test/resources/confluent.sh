#!/usr/bin/env bash

sudo ./bin/zookeeper-server-start ./etc/kafka/zookeeper.properties

#start Kafka in 2nd session, requires running ZK
sudo ./bin/kafka-server-start ./etc/kafka/server.properties

#start SR in 3rd session, requires running ZK and Kafka
sudo ./bin/schema-registry-start ./etc/schema-registry/schema-registry.properties

####
# generate data
bin/kafka-topics --create --zookeeper localhost:2181 --partitions 1 --replication-factor 1 --topic simpleStreaming

bin/kafka-console-producer --broker-list localhost:9092 --topic simpleStreaming

#original data
./bin/kafka-avro-console-producer \
	             --broker-list localhost:9092 --topic nsTest \
		                  --property value.schema='{"namespace" : "ns", "type":"record","name":"myrecord","fields":[{"name":"f1","type":"string"}]}'

{"f1": "value1"}
{"f1": "value2"}
{"f1": "value3"}

#updated schema
./bin/kafka-avro-console-producer \
	             --broker-list localhost:9092 --topic nsTest \
		                  --property value.schema='{"namespace" : "ns", "type":"record","name":"myrecord","fields":[{"name":"f1","type":["long", "string"]}]}'

{"f1": {"long" : 0}}
{"f1": {"long": 1} }
{"f1": {"long": 2} }

#test consumption
bin/kafka-avro-console-consumer --zookeeper localhost:2181 --topic nsTest --from-beginning



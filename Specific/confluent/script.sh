#install
wget http://packages.confluent.io/archive/1.0/confluent-1.0.1-2.10.4.zip
unzip confluent-1.0.1-2.10.4.zip
cd confluent-1.0.1

#start
./bin/zookeeper-server-start ./etc/kafka/zookeeper.properties
./bin/kafka-server-start ./etc/kafka/server.properties
./bin/schema-registry-start ./etc/schema-registry/schema-registry.properties

#send to topic from console, if the schema is incompatible, it will error out
./bin/kafka-avro-console-producer \
               --broker-list localhost:9092 --topic test \
                            --property value.schema='{"type":"record","name":"myrecord","fields":[{"name":"f1","type":"string"}]}'

#read from kafka
./bin/kafka-avro-console-consumer --topic test \
               --zookeeper localhost:2181 \
                            --from-beginning


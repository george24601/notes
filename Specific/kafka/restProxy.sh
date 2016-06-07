curl "http://localhost:8082/topics"

curl "http://localhost:8082/topics/test"

curl -X POST -H "Content-Type: application/vnd.kafka.binary.v1+json" \
      --data '{"records":[{"value":"S2Fma2E="}]}' "http://localhost:8082/topics/test"

curl -X POST -H "Content-Type: application/vnd.kafka.avro.v1+json" \
      --data '{"value_schema": "{\"type\": \"record\", \"name\": \"User\", \"fields\": [{\"name\": \"name\", \"type\": \"string\"}]}",
"records": [{"value": {"name": "testUser"}}]}' \
      "http://localhost:8082/topics/avrotest"


bin/kafka-rest-start

java io.confluent.kafkarest.Main [server.properties]


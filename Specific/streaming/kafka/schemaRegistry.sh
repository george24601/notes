#register a new version of schema
curl -X POST -i -H "Content-Type: application/vnd.schemaregistry.v1+json" \
      --data '{"schema": "{\"type\": \"string\"}"}' \
          http://localhost:8081/subjects/Kafka-key/versions

#register a new version of schmea under different name
curl -X POST -i -H "Content-Type: application/vnd.schemaregistry.v1+json" \
      --data '{"schema": "{\"type\": \"string\"}"}' \
           http://localhost:8081/subjects/Kafka-value/versions

curl -X GET -i -H "Content-Type: application/vnd.schemaregistry.v1+json" \
      http://localhost:8081/subjects

curl -X GET -i -H "Content-Type: application/vnd.schemaregistry.v1+json" \
      http://localhost:8081/subjects/Kafka-value/versions

curl -X GET -i -H "Content-Type: application/vnd.schemaregistry.v1+json" \
      http://localhost:8081/schemas/ids/1

curl -X GET -i -H "Content-Type: application/vnd.schemaregistry.v1+json" \
      http://localhost:8081/subjects/Kafka-value/versions/1

curl -X GET -i -H "Content-Type: application/vnd.schemaregistry.v1+json" \
      http://localhost:8081/subjects/Kafka-value/versions/latest

#Is this schema registered already?
curl -X POST -i -H "Content-Type: application/vnd.schemaregistry.v1+json" \
      --data '{"schema": "{\"type\": \"string\"}"}' \
          http://localhost:8081/subjects/Kafka-key

#Is this schema compatible with latest
curl -X POST -i -H "Content-Type: application/vnd.schemaregistry.v1+json" \
      --data '{"schema": "{\"type\": \"string\"}"}' \
          http://localhost:8081/compatibility/subjects/Kafka-value/versions/latest

curl -X GET -i -H "Content-Type: application/vnd.schemaregistry.v1+json" \
      http://localhost:8081/config

#start schema registry
bin/schema-registry-start etc/schema-registry/schema-registry.properties

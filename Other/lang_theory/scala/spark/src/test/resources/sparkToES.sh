#!/usr/bin/env bash

#start ES
bin/elasticsearch

#start kabana
bin/kibana

#generate jar first
sbt assembly

/Users/georgeli/lib/spark-1.5.1-bin-hadoop2.6/bin/spark-submit \
  --class "SparkToES" \
  --master local[4] \
  /Users/georgeli/repos/confluent-spark/sbtAvro/target/scala-2.10/confluent-spark-assembly-1.0.jar

#check result
curl http://localhost:9200/spark/_search/?size=10&pretty=1

curl http://localhost:9200/spark/docs/_search/?size=10&pretty=1

curl http://localhost:9200/spark


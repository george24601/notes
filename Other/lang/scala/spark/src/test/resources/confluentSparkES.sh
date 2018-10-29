#!/usr/bin/env bash

/Users/georgeli/lib/spark-1.5.1-bin-hadoop2.6/bin/spark-submit \
  --class "cs.ConfluentSparkES" \
  --master local[4] \
  /Users/georgeli/repos/confluent-spark/sbtAvro/target/scala-2.10/confluent-spark-assembly-1.0.jar


curl http://localhost:9200/spark/confluent/_search/?size=10&pretty=1
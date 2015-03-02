SPARK_MASTER=

#start in worker node
./spark-1.2.1-bin-hadoop2.4/bin/spark-class org.apache.spark.deploy.worker.Worker spark://$SPARK_MASTER:7077

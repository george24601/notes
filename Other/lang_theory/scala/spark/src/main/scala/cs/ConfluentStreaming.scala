package cs

import org.apache.avro.specific.SpecificData
import kafka.serializer.StringDecoder
import org.apache.avro.generic.GenericRecord

import org.apache.spark.streaming._
import org.apache.spark.streaming.kafka._
import org.apache.spark.SparkConf
import io.confluent.kafka.serializers.KafkaAvroDecoder

trait ConfluentStreaming extends StreamingJob {

  def getBatchInterval(args: Array[String]) = {
     Seconds(10)
  }

  def run(sparkConf: SparkConf, ssc : StreamingContext) = {
    val brokers = "localhost:9092"
    val topicsSet = Set("nsTest")

    // Create direct kafka stream with brokers and topics
    val kafkaParams = Map[String, String]("metadata.broker.list" -> brokers,
      "auto.offset.reset" -> "smallest",
      "zookeeper.connect" -> "localhost:2181",
      "group.id" -> "group1",
      "schema.registry.url" -> "http://localhost:8081"
    )

    val messages = KafkaUtils.createDirectStream[String, Object, StringDecoder, KafkaAvroDecoder](
      ssc, kafkaParams, topicsSet)

    val objects = messages.map(_._2) //get the value of the KV pai
    val words = objects.map(obj => {
      val genericRecord = obj.asInstanceOf[GenericRecord]
      //genericRecord.get(0).toString //get(0) returns a org.apache.avro.util.Utf8

      val record = SpecificData.get().deepCopy(ns.myrecord.SCHEMA$, genericRecord).asInstanceOf[ns.myrecord]
      record.getF1.toString
    })

    val wordCounts = words.map(x => (x, 1L)).reduceByKey(_ + _)
    wordCounts.print()
  }
}

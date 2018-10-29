package cs

import io.confluent.kafka.serializers.KafkaAvroDecoder
import kafka.serializer.StringDecoder
import org.apache.avro.generic.GenericRecord
import org.apache.avro.specific.SpecificData
import org.apache.spark.SparkConf
import org.apache.spark.streaming.kafka.KafkaUtils
import org.apache.spark.streaming.{Seconds, StreamingContext}
import org.elasticsearch.spark._

trait ConfluentStreamingES extends StreamingJob {

  def getBatchInterval(args: Array[String]) = {
    Seconds(10)
  }

  def run(sparkConf: SparkConf, ssc: StreamingContext) = {

    val brokers = "localhost:9092"
    val topicsSet = Set("nsTest")
    var batchInterval = Seconds(10)

    // Create direct kafka stream with brokers and topics
    val kafkaParams = Map[String, String]("metadata.broker.list" -> brokers,
      "auto.offset.reset" -> "smallest",
      "zookeeper.connect" -> "localhost:2181",
      "group.id" -> "group1",
      "schema.registry.url" -> "http://localhost:8081"
    )

    val messages = KafkaUtils.createDirectStream[String, Object, StringDecoder, KafkaAvroDecoder](
      ssc, kafkaParams, topicsSet)

    val objects = messages.map(_._2) //get the value of the KV pair
    val words = objects.map(obj => {
        val genericRecord = obj.asInstanceOf[GenericRecord]
        //genericRecord.get(0).toString //get(0) returns a org.apache.avro.util.Utf8

        val record = SpecificData.get().deepCopy(ns.myrecord.SCHEMA$, genericRecord).asInstanceOf[ns.myrecord]
        Map("F1" -> record.getF1.toString)
      })

    val esConfig = Map("es.nodes" -> "localhost", "es.index.auto.create" -> "true")
    words.foreachRDD(rdd => {
      rdd.saveToEs("spark/confluent", esConfig)
    })
  }
}

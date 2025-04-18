package cs

import io.confluent.kafka.serializers.KafkaAvroDecoder
import kafka.serializer.StringDecoder
import org.apache.avro.generic.GenericRecord
import org.apache.avro.specific.SpecificData
import org.apache.spark.streaming.kafka.KafkaUtils
import org.apache.spark.streaming.{StreamingContext, Seconds}
import org.apache.spark.{SparkContext, SparkConf}

/**
 * Created by georgeli on 16-06-25.
 */
  trait SparkJob {
    def run(conf: SparkConf, sc: SparkContext, args : Array[String])
  }

  trait SparkMain {
    this : SparkJob =>

    def main(args: Array[String]): Unit = {
      val conf = new SparkConf()
      val sc = new SparkContext(conf)

      run(conf, sc, args);
    }
  }

  trait StreamingJob {
    def getBatchInterval(args: Array[String]): org.apache.spark.streaming.Duration
    def run(sparkConf: SparkConf, ssc : StreamingContext)
  }

  trait StreamingMain {
    this : StreamingJob =>

    def main(args: Array[String]): Unit = {
      val batchInterval = getBatchInterval(args)

      val sparkConf = new SparkConf()
      val ssc = new StreamingContext(sparkConf, batchInterval)

      run(sparkConf, ssc)
      // Start the computation
      ssc.start()
      ssc.awaitTermination()
    }
  }

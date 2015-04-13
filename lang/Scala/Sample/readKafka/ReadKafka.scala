import scala.util.{ Try, Success, Failure }

import kafka.api.FetchRequest;
import kafka.api.FetchRequestBuilder;
import kafka.api.PartitionOffsetRequestInfo;
import kafka.common.ErrorMapping;
import kafka.common.TopicAndPartition;
import kafka.javaapi.consumer.SimpleConsumer;
import kafka.message.MessageAndOffset;

import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

object ReadKafka extends App {

  def processSingleBatch(it: java.util.Iterator[MessageAndOffset], readOffset: Long): Long = {
    var nextBatchOffset: Long = readOffset

    while (it.hasNext()) { //should do a tail recursion call
      val messageAndOffset = it.next()
      val payload = messageAndOffset.message.payload
      val currentOffset = messageAndOffset.offset

      if (currentOffset >= nextBatchOffset) { //offset being read is no less than the offset that we requested
        nextBatchOffset = messageAndOffset.nextOffset
        val bytes = new Array[Byte](payload.limit)

        payload.get(bytes);

        println(new String(bytes, "UTF-8"))
      }
    }

    nextBatchOffset
  }

  def processBatchs(consumer: SimpleConsumer, readOffset: Long): Unit = {

    println("fetch size " + readOffset)

    val req = new FetchRequestBuilder()
      .clientId(clientName)
      .addFetch(a_topic, a_partition, readOffset, 100000) // Note: the fetch size is in bytes not rows
      .build();

    val fetchResponse = consumer.fetch(req)

    if (fetchResponse.hasError) {
      val code = fetchResponse.errorCode(a_topic, a_partition)

      println("error!!!")
      return ;

    } else {
      println("start reading batch..")

      val it = fetchResponse.messageSet(a_topic, a_partition).iterator()

      val nextBatchOffset = processSingleBatch(it, readOffset)

      println(nextBatchOffset)
      println(readOffset)

      if (nextBatchOffset == readOffset) {
        Thread.sleep(10000) //no new message yet, wait

      } else {
        processBatchs(consumer, nextBatchOffset)
      }

    }

  }

  val host = "localhost"
  val port = 9092
  val a_topic = "test"
  val a_partition = 0

  val clientName = "Client_" + a_topic + "_" + a_partition;
  val consumer = new SimpleConsumer(host, port, 100000, 64 * 1024, clientName)
  val readOffset = 0;

  processBatchs(consumer, readOffset)
  consumer.close()

}

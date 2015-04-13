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

  val host = "localhost"
  val port = 9092
  val a_topic = "test"
  val a_partition = 0

  val clientName = "Client_" + a_topic + "_" + a_partition;

  val consumer = new SimpleConsumer(host, port, 100000, 64 * 1024, clientName)

  val readOffset = 0;

  val req = new FetchRequestBuilder()
    .clientId(clientName)
    .addFetch(a_topic, a_partition, readOffset, 100000) // Note: this fetchSize of 100000 might need to be increased if large batches are written to Kafka
    .build();

  val fetchResponse = consumer.fetch(req)

  //why a while here?
  
  if (fetchResponse.hasError) {
    val code = fetchResponse.errorCode(a_topic, a_partition)

    println("error!!!")

    consumer.close()

  } else {
    println("start reading..")

    val it = fetchResponse.messageSet(a_topic, a_partition).iterator()

    while (it.hasNext()) { //should do a tail recursion call
      val messageAndOffset = it.next()
      val payload = messageAndOffset.message.payload
      val offset = messageAndOffset.offset
      val bytes = new Array[Byte](payload.limit)
      payload.get(bytes);
      
      println(new String(bytes, "UTF-8"))
    }
  }

  consumer.close()
}

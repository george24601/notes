import org.apache.avro.generic.GenericRecord
import org.apache.avro.specific.SpecificData
import kafka.consumer.ConsumerConfig;
import kafka.consumer.ConsumerIterator;
import kafka.consumer.KafkaStream;
import kafka.javaapi.consumer.ConsumerConnector
import java.util.Properties;
import java.util.HashMap
import kafka.serializer.StringDecoder
import kafka.utils.VerifiableProperties
import io.confluent.kafka.serializers.KafkaAvroDecoder

/*
Simple I/O case W/O spark
 */
class Confluent {
  def run() = {
    val topic = "nsTest"
    val props = new Properties();
    props.put("zookeeper.connect", "localhost:2181");
    props.put("group.id", "group2");
    props.put("schema.registry.url", "http://localhost:8081");
    props.put( "auto.offset.reset", "smallest")

    val topicCountMap = new HashMap[String, Integer]();
    topicCountMap.put(topic, new Integer(1));

    val vProps = new VerifiableProperties(props);
    val keyDecoder = new StringDecoder(vProps);
    val valueDecoder = new KafkaAvroDecoder(vProps);

    val consumer = kafka.consumer.Consumer.createJavaConsumerConnector(new ConsumerConfig(props));

    val consumerMap = consumer.createMessageStreams(
      topicCountMap, keyDecoder, valueDecoder);
    val stream = consumerMap.get(topic).get(0);
    val it = stream.iterator();

    while (it.hasNext()) {
      val messageAndMetadata = it.next();
      val key = messageAndMetadata.key.asInstanceOf[String]
      val value = messageAndMetadata.message.asInstanceOf[GenericRecord]
      val record = SpecificData.get().deepCopy(ns.myrecord.SCHEMA$, value).asInstanceOf[ns.myrecord]
      //println(value)
      //println(value.get(0))
      //println(record.hasF1()) for unknown reasons, can not compile hasF1!
      println(record.getF1())
    }
  }
}

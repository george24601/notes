package cs

import org.apache.spark.rdd.RDD
import org.apache.spark.streaming.dstream.DStream
import org.scalatest._
import com.holdenkarau.spark.testing._

//StreamingSuiteBase itself extends SharedSparkContext already, which boots up on before and shuts down on after
//and exposes an sc
class SparkStreamingTest extends FunSuite with StreamingSuiteBase {

/*
def rddTokenize(rdd : RDD[String]) = rdd.map(_.split(" ").toList)

test("Non-streaming test") {
  val input = List("hi", "hi cloudera", "bye") //repense a single RDD
  val expected = List(List("hi"), List("hi", "cloudera"), List("bye"))
  assert(rddTokenize(sc.parallelize(input)).collect().toList === expected)
}

def streamTokenize(rdd : DStream[String]) = rdd.flatMap(_.split(" ").toList)
//Notice I used flatmap here, even though the monad is DStream!

test("streaming version") {
  val input = List(List("hi"), List("hi holden"), List("bye"))
  val expected = List(List("hi"), List("hi", "holden"), List("bye"))
  testOperation[String, String](input, streamTokenize _, expected, useSet = true)
}
*/
}
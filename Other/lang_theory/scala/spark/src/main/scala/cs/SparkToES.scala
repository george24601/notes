package cs

import org.apache.spark.{SparkConf, SparkContext}
import org.elasticsearch.spark._


trait SparkToES extends SparkJob {

  def run(conf: SparkConf, sc: SparkContext, args : Array[String]){
    conf.setAppName("SparkToES");
    conf.set("es.index.auto.create", "true")
    conf.set("es.nodes", "localhost")

    val sc = new SparkContext(conf)

    val numbers = Map("one" -> 1, "two" -> 2, "three" -> 3)
    val airports = Map("arrival" -> "Otopeni", "SFO" -> "San Fran")

    sc.makeRDD(Seq(numbers, airports)).saveToEs("spark/docs")
  }
}



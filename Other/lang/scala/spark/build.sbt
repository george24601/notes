name := "confluent-spark"

version := "1.0"

scalaVersion := "2.10.5"

resolvers += "confluent" at "http://packages.confluent.io/maven/"

resolvers += "clojars" at "https://clojars.org/repo"

resolvers += "conjars" at "http://conjars.org/repo"

libraryDependencies ++= Seq(
  "io.confluent" % "kafka-avro-serializer" % "2.0.1",
  "org.apache.kafka" % "kafka_2.10"% "0.9.0.1" ,
  "org.apache.spark" % "spark-streaming_2.10" % "1.6.1" % "provided",
  "org.apache.spark" % "spark-streaming-kafka_2.10" % "1.6.1"
)

libraryDependencies ++= Seq(
  "com.holdenkarau" % "spark-testing-base_2.10" % "1.6.1_0.3.3" % "test",
  "org.scalatest" % "scalatest_2.10" % "2.2.6" % "test"
)


libraryDependencies += "org.elasticsearch" % "elasticsearch-hadoop" % "2.3.2" excludeAll (
  ExclusionRule(organization = "javax.servlet")
  ,ExclusionRule(organization = "org.mortbay.jetty")
)


mergeStrategy in assembly <<= (mergeStrategy in assembly) { (old) =>
{
  case PathList("META-INF", xs @ _*) => MergeStrategy.discard
  case x => MergeStrategy.first
}
}

parallelExecution in Test := false



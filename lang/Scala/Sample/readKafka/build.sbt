val kafka = "org.apache.kafka" % "kafka_2.11" % "0.8.2.1"
val kafkaClients = "org.apache.kafka" % "kafka-clients" % "0.8.2.1"

lazy val root = (project in file(".")).
  settings(
    name := "ReadKafka",
    version := "1.0",
    scalaVersion := "2.11.4",
    libraryDependencies += kafka,
    libraryDependencies += kafkaClients
  )


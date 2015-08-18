lazy val commonSettings = Seq(
  organization := "com.example",
  version := "0.1.0",
  scalaVersion := "2.11.4"
)

val derby = "org.apache.derby" % "derby" % "10.4.1.3"

lazy val root = (project in file(".")). //definites a project here
  settings(commonSettings: _*).
  settings(
     name := "hello",
     hello := { println("Hello!") } //computateion will be re-run each time the task is executed,
     libraryDependencies += derby
  )

lazy val hello = taskKey[Unit]("An example task") 


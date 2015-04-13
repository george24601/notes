val pg = "org.postgresql" % "postgresql" % "9.4-1201-jdbc41"

lazy val root = (project in file(".")).
  settings(
    name := "ReadPG",
    version := "1.0",
    scalaVersion := "2.11.4",
    libraryDependencies += pg
  )


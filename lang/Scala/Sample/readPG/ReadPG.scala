package test2
import java.sql.{ Connection, DriverManager }
import scala.util.{ Try, Success, Failure }

object ReadPG extends App {

  def process(connection: Connection): Try[Unit] = {
    // make the connection

    // create the statement, and run the select query
    val statement = connection.createStatement()
    val resultSet = statement.executeQuery("SELECT current_user FROM user")
    while (resultSet.next()) {
      val user = resultSet.getString("current_user")
      println(user)
    }

    Try(Unit)
  }

  def createCon(): Try[Connection] = {
    val driver = "org.postgresql.Driver"
    Class.forName(driver)
    val url = "jdbc:postgresql://localhost:5432/"
    val username = "postgres"
    val password = "password"
    Try(DriverManager.getConnection(url, username, password))
  }

  for {
    con <- createCon()
    re <- process(con)
  } yield con.close() //should be a match to detect failure case
}

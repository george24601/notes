import io.gatling.core.Predef._
import io.gatling.http.Predef._
import scala.concurrent.duration._

class SampleTest extends Simulation {
  val targetURL = System.getProperty("endpoint")
    val numAtOnceUser = Integer.getInteger("num.user", 8)
    val testDuration = Integer.getInteger("test.duration", 60)
    val firstDataPath = "first.csv"
    val secondDataPath = "second.csv"

    println(s"targetURL: $targetURL")
    println(s"numAtOnceUser: $numAtOnceUser")
    println(s"test duration: $testDuration")

    // Here is the root for all relative URLs
    val httpConf = http.baseURL(targetURL).disableCaching
    val firstFeeder = csv(firstDataPath).random
    val secondFeeder = csv(secondDataPath).random

    val path = "TEST_PATH"
    val test =  http("post-example") // Here's an example of a POST request
      .post(path)
      .body(StringBody("""{"first_id":${first_id}, "second_id":${second_id}, "contexts": {}}""" ))
      .asJSON
      .check(
        status.is(200),
        jsonPath("$..second_id").ofType[String],
        jsonPath("$..returnedBody").exists
      )

      //Note that feed needs to be within the during so that feeder can be evaled for each request
      val scn = scenario("sample-test")
        .exec(
          during(testDuration seconds) {
            exec(feed(firstFeeder))
              .feed(secondFeeder)
              .exec(test)
          }
          )


        setUp(scn.inject(atOnceUsers(numAtOnceUser)).protocols(httpConf))
}

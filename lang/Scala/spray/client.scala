import spray.http._
import spray.client.pipelining._

implicit val system = ActorSystem()
import system.dispatcher // execution context for futures

val pipeline: HttpRequest => Future[HttpResponse] = sendReceive //The function type is also aliased to SendReceive

val response: Future[HttpResponse] = pipeline(Get("http://spray.io/"))

/////////
//wrap pipinling  around spray=can's Host-level API, need to tell sendRecieve which host connector to use
val pipeline: Future[SendReceive] =
  for (
    Http.HostConnectorInfo(connector, _) <-
      IO(Http) ? Http.HostConnectorSetup("www.spray.io", port = 80)
  ) yield sendReceive(connector)

val request = Get("/") //because we wrapped already, we can fire requests with relative URIs and without Host header
val response: Future[HttpResponse] = pipeline.flatMap(_(request))

//////////

case class Order(id: Int)
case class OrderConfirmation(id: Int)

object MyJsonProtocol extends DefaultJsonProtocol {
  implicit val orderFormat = jsonFormat1(Order)
  implicit val orderConfirmationFormat = jsonFormat1(OrderConfirmation)
}
import MyJsonProtocol._


val pipeline: HttpRequest => Future[OrderConfirmation] = (
  addHeader("X-My-Special-Header", "fancy-value")
  ~> addCredentials(BasicHttpCredentials("bob", "secret"))
  ~> encode(Gzip)
  ~> sendReceive
  ~> decode(Deflate)
  ~> unmarshal[OrderConfirmation]
)

val response: Future[OrderConfirmation] =
  pipeline(Post("http://example.com/orders", Order(42)))






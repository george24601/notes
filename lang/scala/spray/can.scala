import akka.io.IO
import spray.can.Http

implicit val system = ActorSystem()

val myListener: ActorRef = // ...

IO(Http) ! Http.Bind(myListener, interface = "localhost", port = 8080)

//inside ActorRef definition
def receive = {
  case HttpRequest(GET, Uri.Path("/ping"), _, _, _) =>
    sender ! HttpResponse(entity = "PONG")
}



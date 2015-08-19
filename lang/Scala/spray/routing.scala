import spray.routing._

//path and get are part of routing DSL
class MyHttpService extends HttpServiceActor {
  def receive = runRoute {  //runRoute connetx route structore to the enclosing actor by constructor Actor.Receive parital funciton
    path("ping") {
      get {
        complete("PONG") //complete is actually a directive
      }
    }
  }
}


val route: Route =
  path("order" / IntNumber) { id =>
    get {
      complete {
        "Received GET request for order " + id
      }
    } ~
    put {
      complete {
        "Received PUT request for order " + id
      }
    }
  }

///example of composing directives

def innerRoute(id: Int): Route =
  get {
    complete {
      "Received GET request for order " + id
    }
  } ~
  put {
    complete {
      "Received PUT request for order " + id
    }
  }

//extract with case class
case class Color(name: String, red: Int, green: Int, blue: Int) {
  require(!name.isEmpty, "color name must not be empty")
  require(0 <= red && red <= 255, "red color component must be between 0 and 255")
  require(0 <= green && green <= 255, "green color component must be between 0 and 255")
  require(0 <= blue && blue <= 255, "blue color component must be between 0 and 255")
}


val route =
  path("color") {
    parameters('red.as[Int], 'green.as[Int], 'blue.as[Int]).as(Color) { color =>
      doSomethingWith(color) // route working with the Color instance
    }
  }

val route: Route = path("order" / IntNumber) { id => innerRoute(id) }


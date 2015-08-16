object ApplicationMain extends App {
  val system = ActorSystem("MyActorSystem")
  val pingActor = system.actorOf(PingActor.props, "pingActor")
  pingActor ! PingActor.Initialize
  system.awaitTermination()
}

class PingActor extends Actor with ActorLogging {
  import PingActor._ //need to know the type and the message

  var counter = 0
  val pongActor = context.actorOf(PongActor.props, "pongActor") //notice pong is within ping, props is from Pong's companion object

  def receive = {
        case Initialize => pongActor ! PingMessage("ping")
        case PongActor.PongMessage(text) =>
          counter += 1
          if (counter == 3) context.system.shutdown() //
          else sender ! PingMessage("ping")
  }
}


class PongActor extends Actor with ActorLogging {
  import PongActor._

  def receive = case PingActor.PingMessage(text) => sender ! PongMessage("pong")
}

object PongActor {
  val props = Props[PongActor]
  case class PongMessage(text: String)
}

/////////////

class HelloWorld extends Actor {

  override def preStart(): Unit = {
    // create the greeter actor
    val greeter = context.actorOf(Props[Greeter], "greeter")
    // tell it to perform the greeting
    greeter ! Greeter.Greet
  }

  def receive = {
    // when the greeter is done, stop this actor and with it the application
    case Greeter.Done => context.stop(self)
  }
}

object Greeter {
  case object Greet
  case object Done
}

class Greeter extends Actor {
  def receive = {
    case Greeter.Greet =>
      println("Hello World!")
      sender() ! Greeter.Done
  }
}

object Main2 {

  def main(args: Array[String]): Unit = {
    val system = ActorSystem("Hello")
    val a = system.actorOf(Props[HelloWorld], "helloWorld")
    system.actorOf(Props(classOf[Terminator], a), "terminator")
  }

  class Terminator(ref: ActorRef) extends Actor with ActorLogging {
    context watch ref
    def receive = {
      case Terminated(_) =>
        log.info("{} has terminated, shutting down system", ref.path)
        context.system.shutdown()
    }
  }

}

///////////

class HelloAkkaSpec(_system: ActorSystem) extends TestKit(_system) with ImplicitSender with Matchers with FlatSpecLike with BeforeAndAfterAll {

  def this() = this(ActorSystem("HelloAkkaSpec"))

  override def afterAll: Unit = {
    system.shutdown()
    system.awaitTermination(10.seconds)
  }

  "An HelloAkkaActor" should "be able to set a new greeting" in {
    val greeter = TestActorRef(Props[Greeter])
    greeter ! WhoToGreet("testkit")
    greeter.underlyingActor.asInstanceOf[Greeter].greeting should be("hello, testkit")
  }

  it should "be able to get a new greeting" in {
    val greeter = system.actorOf(Props[Greeter], "greeter")
    greeter ! WhoToGreet("testkit")
    greeter ! Greet
    expectMsgType[Greeting].message.toString should be("hello, testkit")
  }
}





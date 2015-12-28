object Terminator {
  case class GetChildren(forActor: ActorRef)
  case class Children(kids: Iterable[ActorRef])
}

class Master(surrogate: ActorRef) extends Actor {
  override def preStart() {
    surrogate ! GetChilren(self)
  }

  def waiting : Receive = {
    case Children(kids) =>
      context.become(initialized(kids))
  }

  def initialized(kids: Iterable[ActorRef]) : Receive = {
    case _ =>
  }

  def receive = waiting
}

///PROBLEM: modify code to start master before workers
abstract class Terminator extends Actor {
  implicit val stopTimeout = 5.minutes
  case object AllDead

  def order(kids: Iterable[ActorRef]):Iterable[ActorRef]

  def killKids(kids: List[ActorRef]): Future[Any] = {
    kids match {
      case kid :: Nil =>
        //Future it returns completes only after the Actor's postStop()
        gracefulStop(kid, stopTimeout).flatMap { _ =>
          Future { AllDead }
        }
      case Nil =>
        Future { AllDead }
      case kid :: rest =>
        gracefulStop(kid, stopTimeout).flatMap { _ =>
          killKids(rest)
        }
    }
  }

  def waiting: Receive = {
    case GetChildren(forActor) =>
      watch(forActor)
      forActor ! Children(children)
      become(childrenGiven(forActor))
  }

  def childrenGiven(to: ActorRef): Receive = {
    case GetChildren(forActor) if sender == to =>
      forActor ! Children(children)
    case Terminated(`to`) =>
      killKids(order(children).toList) pipeTo self //pipeTo sends the result of future to an actor
    case AllDead =>
      stop(self)
  }

  def receive = waiting

}

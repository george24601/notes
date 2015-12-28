sealed trait State
case object Idle extends State
case object Active extends State

case object Tick

sealed case class Data (
  target: Option[ActorRef],
  vouchersLeft: Int,
  queue: Q[Any]
)

def deliverMessages(d: Data): Data = {
  val nrOfMsgToSend = min(d.queue.length, d.vouchersLeft)

  //PROBLEM:we need transparent sender, not just the throttler
  d.queue.take(nrOfMsgToSend).foreach(d.target.get.tell)

  d.data.copy(queue = d.queue.drop(nrOfMsgToSend),
    vouchersLeft = d.vouchersLeft - nrOfMsgToSend
    )
}

//PROBLEM: can not change rate
//state you do not need to patern-match is a candidate for storing as member fields
class TimerBasedThrottler(var rate: Rate) extends Actor with FSM[State, Data] {
  startWith(Idle, Data(None, rate.numberOfCalls, Q[Any]()))

  when(Idle) {
    case Event(SetTarget(t @ Some(_)), d) if !d.queue.isEmpty =>
      goto(Active) using deliverMessages(d.copy(target = t))

    case Event(SetTarget(t), d) =>
      stay using d.copy(target = t)

    case Event(Queue(msg), d @ Data(None, _, queue)) =>
      stay using d.copy(queue = queue.enqueue(msg))

    case Event(Queue(msg), d @ Data(Some(_), _, Seq())) =>
      goto(Active) using deliverMessages(d.copy(queue = Q(msg))

  }

  when(Active) {
    case Event(SetTarget(t @ Some(_)), d) =>
      stay using d.copy(target = t)

    case Event(SetTarget(t @ Some(_)), d) =>
      stay using d.copy(target = t)

    case Event(Queue(msg), d @ Data(_, 0, queue)) =>
      stay using d.copy(queue = queue.enqueue(msg))

    case Event(Queue(msg), d @ Data(_, _, queue)) =>
      stay using deliverMessages(d.copy(queue = queue.enqueue(msg)))

    case Event(Tick, d @ Data(_, _, Seq())) =>
      goto(Idle)

    case Event(Tick, d @ Data(_, _, _)) =>
      stay using deliverMessages(d.copy(vouchersLeft = rate.numberOfCalls))
  }

  onTransition {
    case Idle -> Active => setTimer("moreVouchers", Tick, rate.duration, true)
    case Active -> Idle => cancelTimer("moreVouchers")
  }

  initialize
}


//Testing code

val echo = system.actorOf(Props[TimerBasedThrottlerSpec.EchoActor]
  val throttler = system.actorOf(Props(
    new TimerBasedThrottler(new Rate(3, Duration(1, TimeUnit.SECONDS))
      )))

throttler ! SetTarget(Some(echo))
throttler ! Queue("1")

//..sends message from 1 to 7
within(1 second) {
  expectMsg("1")
  expectMsg("2")
  expectMsg("3")
  expectNoMsg(remaining)
}

within(1 second) {
  expectMsg("4")
  expectMsg("5")
  expectMsg("6")
  expectNoMsg(remaining)
}
